Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0EB47C0AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhLUNTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:19:49 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:10867 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhLUNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:19:48 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211221131945epoutp031745ed36c5b771162d5330327f323541~Cx7L-_9hR0259702597epoutp033
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 13:19:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211221131945epoutp031745ed36c5b771162d5330327f323541~Cx7L-_9hR0259702597epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1640092785;
        bh=CXyCFLfPQb3fk0Wa9KEUmKrY1neR+3waQ8bjm8cVIlM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=jYyt4iUh2SM1HYBePfDav+jg3RCggvI1ZupsX236AROTIz7UgQYepColkItYMa576
         n9HW9FdMSIWH0WolN+lLn1jik+LoarVLMEFzy15NiPrw+fxGXzABbkrfnaa+k2N37N
         0DubQdTQwk3jwCrGPdC6HDUaYNZkS/l8WP+r6exA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20211221131945epcas5p2f0be3374955094396b6faba21043836b~Cx7Lvtuuy1205912059epcas5p2-;
        Tue, 21 Dec 2021 13:19:45 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-3f-61c1d471d241
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.71.06423.174D1C16; Tue, 21 Dec 2021 22:19:45 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/1] Smack:- Fix the issue of wrong info printed in
 ptrace error logs
Reply-To: vishal.goel@samsung.com
Sender: Vishal Goel <vishal.goel@samsung.com>
From:   Vishal Goel <vishal.goel@samsung.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <a648c816-3093-8023-d96c-b1b8d459430f@schaufler-ca.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20211221131233epcms5p2e334598b208dcd76f6efec26f879c784@epcms5p2>
Date:   Tue, 21 Dec 2021 22:12:33 +0900
X-CMS-MailID: 20211221131233epcms5p2e334598b208dcd76f6efec26f879c784
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZdlhTXbfwysFEgwv75C0u7k61uLftF5vF
        wRN7GS0u75rDZvGh5xGbxaGTcxkd2Dze77vK5tG3ZRWjx9H9i9g8Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mq4+Gw9Y8Ea7or/6/oZGxjnsHUxcnJICJhItB3+z9rFyMUhJLCbUaLj3hzmLkYODl4B
        QYm/O4RBaoQF4iVu/37CDmILCShKrFg+jxGkRFhAV2LelACQMJuAtkTvvLtMIGNEBA4xSpz9
        toIRxGEWaGWU2D5rJxPEMl6JGe1PWSBsaYnty7cygticAi4Sr5res0PERSVurn4LZ78/Np8R
        whaRaL13lhnCFpR48HM3VFxGYsKcs2APSAi0M0qc/neSEcKZwCjRtPo4VJW5xPolq9ghPvOV
        2NDFCRJmEVCVOLBzH9QyF4l1T76AHccsIC+x/S0kIJgFNCXW79KHKJGVmHpqHRNECZ9E7+8n
        cH/tmAdjq0pMndTNDvPj4RtnoP71kHi/rAca0L8YJdb0/GebwKgwCxHWs5BsnoWweQEj8ypG
        ydSC4tz01GLTAsO81HK94sTc4tK8dL3k/NxNjOCkouW5g/Hugw96hxiZOBiBEcDBrCTCu2X2
        /kQh3pTEyqrUovz4otKc1OJDjNIcLErivKfTNyQKCaQnlqRmp6YWpBbBZJk4OKUamJqWM71K
        vxv5k5/z3vLsHVbGE17aMVlFSR9NZ/2zvrp+35dnzUJifrcuqZ54fzFBL2/P1MNi3+v4rsY8
        yLmwaXbFchGf1p8T+/Iqn827EuukkdWx8t7Zdu8EUcG0eU8+PDnr5B/4qu/J8UdNjPUskbN1
        Sorj/oWoZh/gqkoXf2P8o0/r7v89H3j5j5p8PMvBsHt7Q3OlyzuV+b/0HMX8Le/ePhrDccD0
        xQNnkbCDc5eoHXyt7Jrov8Vwb+tuv18bLDv2rl/r1zFf0nLPxA2XF2xY9ua5C+/qKdPaogy2
        rpzgqnz/xOsvUqo3nqnNsmrK331uVfXl/AVdC5TNGbf9DHwetakhcJXEzamzWhzl9+xTYinO
        SDTUYi4qTgQA0BqADJkDAAA=
X-CMS-RootMailID: 20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7
References: <a648c816-3093-8023-d96c-b1b8d459430f@schaufler-ca.com>
        <20211220101318.3538824-1-vishal.goel@samsung.com>
        <3ccb78ef-905c-4914-c77a-24765c0e6675@schaufler-ca.com>
        <CGME20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7@epcms5p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
> 
> What test case do you have that generates these records?

Test case for 1st log:-
void main(int argc,char *argv[])
{
        int pid;

        if (argc < 2) {
                printf("enter pid of the tracee process\n");
                exit(0);
        }

        pid = atoi(argv[1]);
        fprintf(stderr,"Inside\n");
        ptrace(PTRACE_ATTACH, pid,NULL,NULL);
        while(1)
        {
                sleep(10);
        }
}

Test case for 2nd log:-
void main(int argc,char *argv[])
{
        int pid;

        pid = getpid();
        fprintf(stderr,"Inside\n");
        ptrace(PTRACE_TRACEME, pid,NULL,NULL);
        while(1)
        {
               sleep(10);
        }
}

Test case for 3rd log:-
void main()
{
        int pid;
        char *argv[2];

        fprintf(stderr,"Inside\n");
        pid = fork();
        if(pid == 0) {
                argv[0] = "/tst_pt";
                argv[1] = NULL;

                if(ptrace(PTRACE_TRACEME, pid,NULL,NULL))
                        printf("attached child\n");

                printf("going for exec\n");
                execv("/tst_pt",argv);
        }
        else
        {
                while(1)
                {
                        sleep(10);
                }
        }
}

>>
>> Added linux-audit to the CC list.
>>

Thanks
Vishal Goel
