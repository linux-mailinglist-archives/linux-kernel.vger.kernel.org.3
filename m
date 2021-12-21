Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E6E47C46C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbhLURBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:17 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:34083
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240112AbhLURBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640106070; bh=B52Bi9SSUTeVc5dexD1iu0wdQkDqh0C1Oku/cCpF37s=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HqMy8/Tr/WrEca3GqxMYe6FuvBbSIiswbiUVjSEElcw1HAuGhSCHGZpSGp+NW08nQjYRu7p0cW3YNOpTeTw7MF+voqf23078IJysvruZFWSB1glDD/IJMNeS+/nVCxcIu3fvouZYUzMNAQG8b9l1gTpgFbUCDPxbdubBr5sDPk9StXheLUEZyEWmy2FXO5gddg/BbFWUFyNHC5FV6cASLHfgmzoikg9aSTF3aOPmD6y4ln42Q/2pZKd0Ev3IiCP4nR6QtoWRqEjRxQyEw5C8p1TASbnlWivtUPt9wZPD7LesmM2FolfkkPdjwQb0GniiaBM8rcuZJsVZO1kUJL3fMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640106070; bh=ONILMENR5AfCI6T+sI4sezGmmGsXWo66OodpxoEAb5P=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uLovyd6fT7eCOdSKzdZi3VT/KpFw28x2U9YTR3N3pw1x5HkiDTt3IZ5WLksoUnqytjYEs8qT6JgTwkjKqCeIdIOEMOYXzYvqFvMXFiSIfMSQHqTAFB+Y3UyAIS6cR7W7hPDJ4TqQ1P6LdaMb1R+ZBco88nJgb6LWKvZkkwjLg2RsZvY32QSyQqMCTFcE/AHJ9H6XOhR3vgz+OD72npPhQTAhETsThHynbUlmY6tnY1mYbFaYuXrGrNXgP6Vz1VVbvha0BDodW4UKN0ralYOSqF/Z37cR84LK1iIsMMDLqsFsrt5q1hV2EMuzmKNENEjS47DMF7HPGQbHyMIBQLaLwA==
X-YMail-OSG: qPllEeoVM1nWKCNmboo9wkyLOWVIY86d2ePomLULgH2f1SBFzdnlxGdNP08gRzP
 2221ETu67Gw3dBcviI376k283WrMcwPuPB6iB_uL6o7j5ur.vlTzkTt4_sQntueL1abttamuYGk.
 8.iSlo8rGHHEjPtudN0FhpoOG.xtm9FIulv_MSRKZgsJORhVh4.xdCaRBh8LxtU0qeYxLc4tAiYE
 D7vWGoZAwYEOeoSVNcMgobDqDPXA5NV_b_2Ei.wSZVEBIZ0Uw5VatRfvTANDFAWolFLnQ.HmdFSW
 gwmJVAGiVJ_pX6VYc8ODYs9xs1ga5vf.tdDE.cpuUu2lPAl9KtoV0uaC181ZHVult4xDq1meVz1r
 kxT7z940N1NR0l6urteuTu9NHkbIxLM1Rxykpd.fmZnI5oK2El.GqDWPLcLr5SUTR.mpoKOACAON
 gmx5vokvh0YYmfrV8GWlFrsD946k4z3zVhsez3xGTK5gcj048Saw8drwgiPosF5TvAdqYdK1OR8a
 yRrZJ9Hz5JYO6eyip.tWw9yp8kIdKpgLNBHPpdgP1v601fFAHWcgvZYBtIm.GYvCmiTEni872kuK
 iyG_GNnCqXrpzk5KcH9v.xBX6.fUnIcLTDd51.Grgt.BWZ0.ohvy5aVAZMD7Nk1uzXKWRz5EiEVI
 9rNjyC5ylmWAhE97qdUDY7rmD5ecVTah_0xG6lb4FP4ZSpvvIhKmA8IB0KlUBuP11cLJqs7P13V5
 .LJJhzlTMUXyZWnY2da7fnwjOHb2dD71KYKGqOeW_C2yY4vuKYuWHCK2VXb5sbeVnPT0Ckr2cba9
 kbtj1wQYObw41uGuJK.tEDO3Kg7_v9QIQnX98n64hh2t5siu7dZN7QebIJo9kpsB82rXw2rTyWDA
 Q1CPne_VSO7.peJCg3lB1BVTYCwcBkPHsRb.IhQ067Ywf8kb88yQXhYPI0rmgnIhkPukhHYV.G5p
 qqUSopZnCkPkw.q73oz9fzYk3o7JbpAusqIZDqZeIm9G5sPS7F9qHfnpvOdGqpuGNRNrlT2cmNGE
 02qOOSYOuMkeZSCBtMrxFjjJOnQU0Ar_tBC3_Ltq2EgJ9tmNVfT8gOG68MxS3gQ6lCAxQA.akMNx
 y_TENldWWrrGrzoetH3Pe7tvuM5qbwVwRjE0zmdcA4bq1v0YRCe_9KLrGKinq8Hh18ECT7lF87hj
 y1LhGucAqBzzoKAAvUdVpSq81ctvE99vphMDHBpLFs0MsVAsKr3sTmIzKqqa5lzDYyL7UMLtjMO4
 rj6Z9sXJE1JcCWzi6uLOAOBjkEfTkIqheX1nLUw2OMWwEGRZa7NeHQv8_ZTycwF4T0ULPJQXaRya
 7ht.dXvdkiirYb00IABtXCa0yGqkTbKKg81CA.8IR11YKdy40jjHimhxt32xZULQe8FyGswXygB_
 F0wW2EPhRMXonqxs4kEDs2nP6oucUBmQa91c3oP4YjMpEt4MOLPo8a1MmhxB1mYiZhqF9_yp7dZz
 ZjVBQ8HGiCa14pPNpBfmZ6tv31pzIKcP0aF6HSJoWlroQA_vPCZg948QcpaGWSKD0T61yd5sjvUf
 07OqXzcXUm4Cj98kGXhApaNFIYUgBvjEjW49pLpKkWKo2PGGd8z46uW9FxWZBB5cOKYovFwQnWKe
 Kog28tN2Ygb.1Gd6j_vVcKa1PSdVNNnuuGDequ1NO7Ypr_Q_mQq_E1405kI4w0TzdORcO2rw0Cuv
 GxL88_whWDQXxTwZEAUrsysOZDaeLR4coe1I0yU2T_MuRY.0qXMTu.SohQaeU8f_zTHm96Mdfh6L
 JbSaeC4ahbn_SWsRSrJ5Bb8cEBwbA4kh9MuRu4FjMEBHcO5aBdiuBTw7ZOimljccHxwvKQf6WLv8
 jsg5hjapwhCRnqeVZyHy7xipAwLBrwVg3r3Wrscw6iKg_JmNmzMtfDTK4axLRiLW6RFhRmgI_KtV
 dN6qQCIWknW2SI5xMa7zAV7QmEaPNAl00v.bSE6XAOMuoD7Gt69novcpzP2R.p4qzb2Yi2D7CDtX
 vwHUe2cRav_kzmf22IGOi65xHA6UCAsU.4oS6IzWiVgmJpbpPUKBw9bIFDs7Ykk8aiiAUGKDbHPF
 4p9epA1upYphi4LnrZlxJsAHjL7XYlAlAV4VXuldJtfwb1r8kHn_.X4i6gOffx20tZBDG8K_DSRn
 xPrjcycKnugqUby4o.qD02kskPv0BstOodHBOTDc0TeAQXsCTXJY51katVonT7hTxhEynARjfGp6
 Y1j0msYkU7tkf
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Dec 2021 17:01:10 +0000
Received: by kubenode531.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 36fbb5b50f8120d1c4a48feac20131ee;
          Tue, 21 Dec 2021 17:01:04 +0000 (UTC)
Message-ID: <0163902a-a442-7e43-8f73-5321109e8985@schaufler-ca.com>
Date:   Tue, 21 Dec 2021 09:01:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] Smack:- Fix the issue of wrong info printed in ptrace
 error logs
Content-Language: en-US
To:     vishal.goel@samsung.com,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <a648c816-3093-8023-d96c-b1b8d459430f@schaufler-ca.com>
 <20211220101318.3538824-1-vishal.goel@samsung.com>
 <3ccb78ef-905c-4914-c77a-24765c0e6675@schaufler-ca.com>
 <CGME20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7@epcms5p2>
 <20211221131233epcms5p2e334598b208dcd76f6efec26f879c784@epcms5p2>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211221131233epcms5p2e334598b208dcd76f6efec26f879c784@epcms5p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19498 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/2021 5:12 AM, Vishal Goel wrote:
> Hi,
>
>>>> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
>> What test case do you have that generates these records?

Could you include a permissive license with this code?
I'd like to add it or a derivative of it to the Smack test suite.

> Test case for 1st log:-
> void main(int argc,char *argv[])
> {
>          int pid;
>
>          if (argc < 2) {
>                  printf("enter pid of the tracee process\n");
>                  exit(0);
>          }
>
>          pid = atoi(argv[1]);
>          fprintf(stderr,"Inside\n");
>          ptrace(PTRACE_ATTACH, pid,NULL,NULL);
>          while(1)
>          {
>                  sleep(10);
>          }
> }
>
> Test case for 2nd log:-
> void main(int argc,char *argv[])
> {
>          int pid;
>
>          pid = getpid();
>          fprintf(stderr,"Inside\n");
>          ptrace(PTRACE_TRACEME, pid,NULL,NULL);
>          while(1)
>          {
>                 sleep(10);
>          }
> }
>
> Test case for 3rd log:-
> void main()
> {
>          int pid;
>          char *argv[2];
>
>          fprintf(stderr,"Inside\n");
>          pid = fork();
>          if(pid == 0) {
>                  argv[0] = "/tst_pt";
>                  argv[1] = NULL;
>
>                  if(ptrace(PTRACE_TRACEME, pid,NULL,NULL))
>                          printf("attached child\n");
>
>                  printf("going for exec\n");
>                  execv("/tst_pt",argv);
>          }
>          else
>          {
>                  while(1)
>                  {
>                          sleep(10);
>                  }
>          }
> }
>
>>> Added linux-audit to the CC list.
>>>
> Thanks
> Vishal Goel
