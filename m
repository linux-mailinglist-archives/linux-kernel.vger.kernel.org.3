Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC5D593561
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbiHOSXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbiHOSW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:22:59 -0400
Received: from sonic310-21.consmr.mail.gq1.yahoo.com (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF92DAB0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660587442; bh=3s531Pd45xAL3WDjGl79WaBT/cIfjLGMa/q/nD5W+W4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nXt0NNd+84LNPDfCP5PnDgVXLr83Zb0d9wCuWquu2R1Q1vKvJYMqgtXctndKE3xenr1e2n5QI+O+daXxxnFSAccLI821xdAl4Zp5V2PilZRPKYpd2dMTCP6IYkyoa//6JMsc1Fq2FlDzsPMVoUHj2nKaG/0zFrqNjL5y8b4fqWZKKKQ6haGY8vxWzOp6G1m65oSyv/yCAJ4ARntZJcoazvHA6EbMvG0wnhQ3u/izcckNsvt00IWFLhHjWdfYjZAyImzMNW5+eVjHIW+FY/7bZrz+6TZf60GBwuR/yJYGayjkvCDcoVUjrzDhAs+NbATEunFdDtcupjhalZrayUuc5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660587442; bh=TsST2RuuTsY45uRxXDELW0uQDUn7huiOUvHVBJMEcWR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qDycNvblgIVG0m+5S7Dy4ZVPx/slsES1ZauZTAVbwqvzsYMpYtNCKiZ33k2exDr7cDewy2fG9UDH9s1/sUQ4GG7l00jwO4HXCY8sVpqBK9gncWyWIGPOArQMjdiQfcDbvy0C4CnBmSlom2ByezhZlKcDukG//MRwbjAq9NGs3LKqhCsGq5BPFQ/jpDKdYZm4NjVPOdqzgY1pSJQFNZBXpZpcYOQktW6jeIKo56tdmjVSOH+OMEe3ZmoPMdjjjh8g4oKNtay4mLtB1U9ek6FUU0yqmdtPQnoGMWZKhxmNW8mCbhGbbW+pFi2yFlJ9D+Dh5w1K+oSMh0k0ei7VxF78yg==
X-YMail-OSG: KR4D4v8VM1nC33Fe42cMm4tJLG5.n9tLYom.HdhBKhsZWsXfo8mNAIaqPncAxYw
 0.Gdi2E1JKUvefbEdR8plvDvbqtPVF1WY6F7JeJoepW1xKIfC.a94KAlC9cyz1LgYBen6TtVbmFT
 GK.0pyF2Opro1bzJuIZP5fvXqTosQlioP1GlzipnzOaG0lqnKdCkwyDnKZNnhmvAXCTD_ogBQAc6
 8oERlj.rx0qeL_C6niLKkGIHhTWxUo0apwj_JgMLZVQb6g1mirQ4jIEDQjtTJKDl0fmNQDktejLY
 Q5bgFtxGxxRCvwoQQxBSJlDcfEWRg59vOIb1utHoTVxxFp9Sq_fn95QcdsM5oh5lRlTfazAFXeAR
 fhDIgxmA_d.V9y.kFclbzkQto2X5gh4RLLdSm5F9cxa4F4jvWUHcOXVH5TVbNN8fFTampw6RWGVb
 K0XcWS8RbcBaK2OVeyORZwMcu8f7IfKamDjrhJI.WTw5yzq070H1nksi.fVfA3xrZG01QBXtx5p_
 d.dRQnl4IK0vSrWyqzpb8KLlE9kjwPDXSwdPg5fQE.3PrNZqKWurxFc1yKlvwjfiO_vJzO.fBNih
 0_IDUCEp63BpdK_KKR9zN6rDrbCQqyeXtWbJjsuJ1wSd71pRm1VDjm_5_3AMbS385ayosHiCCNTf
 XnUFFk8X2HAzvG3eWur9EaWVVbbKvILsqNyiS072ODDaIYBt4Rh4I_qfYCIf0NBURqT7YbBqkRVG
 3X4CcCDIdYyYrn06ac8FfuefQ8K6Jk6krsjqLzeNn_QdipKV6uI9V768518b.uXYPsuODgoaCTiL
 LWJ7P9tys7t2t58AV93U5x1o6zfmWk_6s5CZledc_dc6Vrkm7GITqWk96zNxuXoAm4nLz7rEdpbX
 A_6cYq_utLB4.ER4XqYnMgpU9DNFtG1LpfYi5Z1PAM58LCrkbbSHF_U52vn0NiEc92ocLsigZhDj
 VeXCN3Rp26mmefw7glHFgFr1b5Zd04xA2KETJNgVGKMnQ2lNn9qXDnSmzrUUxz08pXhgWGKsHrRu
 gB_Z1gZsidsXZ6HPYzPh4AAT6yddRJ9c1F1S1h.b6J1uES5EBcDLMLYqAOy.kLMo5yFv04eSLW4T
 96q68sMJ6Tf9CFisXcoJtol_MJw5xSyvkGZH7kg3IRwvpDkpcQsfr9TzspeSIzcDnEeRuf8bEXnd
 JgsO9APF5JUQdNCUABwMB4vdOSY5YHZvxETMGhkX1zBz9CaMAqV7Wu.eIsPw_6m02caWImgnfFkS
 ZZPruMfXhz6CTDbPcs9IhRmYaNQOPL0G8tpi.n6vhb_GeNS42nWzckep6aIfPhqUYO4MdH_cwUDd
 Q2XuT8I1rd.E4fIo0qFBT1ADVybFPlgS8PdJz_dCgqnM8YHtj44UodjUxPsbIx2vwca7r0G8RIZ7
 IpSZ.QZrVvOXbM5LQzqfe_gTNjZE7UAucmqvIPNiSxBC23t8BqhctEf6oVcyEBkK4S7541RCJo5Y
 aYjshe2lScGKfLoMgZ2SyFYo3pvjwURas21iO7qM3SW5XZ308G5xuY.8u7vxo62qp1wS77d72c71
 AfOChuUkF1hwbInpElD1F_HsvFQqVr1oO1tZnOpUJlcedyrxrdOB00Ss0JDgx6WFga4hvjodGnLV
 z0H2Y1yQwDfKmKROb.tqTltHikg7QDR1tCDSE9ylMl6703Yli.BmD95GGPxj59yDens4KItVyLed
 vKoCuYPcXH_6t9oPVne4cTCbh1ForCaGyvVFAJWRoUutARHU1ZjSDUG2kDM6Z97GlgPy2LqO5xWT
 K_oSxlcl5HBze6Bo9QpgnmftlEoEQy4eN.WS6.sosSfiIfE0Kb2_RT330Fym2Lk9WrXu3ohgMAuF
 nUutQmmKvTGjPeY.go1KEzA6Ac6kNoOBeaFe1JAQ8CVyKU5hrcaSdIA1ycXyz1DkWawHjnWB1v1s
 ks6HreFerYVmVCf.johBcvjXdXd3l3QUXEXdgK3aO1ihGcr0_ZGbss9hdOG.iOm6ZK0Rg5Cb0cim
 .6bV0LQFxNTIsJGvFq2fPHwkjcKJPXIuRj8vvcfjEK_pAnyw.ygPfFeTJxBR8K8xI_pKswof1LWs
 __Y4s5p6723A3TsCUgid5ulehsyJOUN_d3KFa8t8vBnsVO_4iD8RnThv76VEAldrVLB4qe5IujqC
 DugKjQyn47w.K9ui0c1CNmOis4H4__8GSD7zdeEAV3Gk090_SPmFlUcAIuCG.0WBQBOvOqmrqFeY
 U5LSflnmNFUAPKp.Cgg--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 15 Aug 2022 18:17:22 +0000
Received: by hermes--production-bf1-7586675c46-klczj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e7a9986af8b5cf78b3987899a0ba9fa0;
          Mon, 15 Aug 2022 18:17:17 +0000 (UTC)
Message-ID: <8d148826-62a5-95f9-8662-be14f56a6336@netscape.net>
Date:   Mon, 15 Aug 2022 14:17:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
 <bd66b5bc-4d07-d968-f46c-40cf624499a7@netscape.net>
 <a29a66e0-2075-8084-84ad-8bd3e8a9fd4a@netscape.net>
 <a7d10605-87e3-c4bd-4a76-f07a04f5751c@leemhuis.info>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <a7d10605-87e3-c4bd-4a76-f07a04f5751c@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/2022 2:00 PM, Thorsten Leemhuis wrote:
> Hi Chuck!
>
> On 15.08.22 18:56, Chuck Zmudzinski wrote:
> > 
> > I am forwarding this to you to help you cut through the noise.
>
> Sorry for not replying earlier, I ignored this thread and all other
> non-urgent mail in the past two weeks: I was on vacation until a few
> days ago and when I came home I had to deal with some other stuff first.
>
> > I do not apologize for trying to get
> > the fix for this regression rolling again.
>
> Yeah, it's important to ensure regressions don't simply fall though the
> cracks, but my advice in this case: let things rest for a few days now,

Actually, I was planning on letting things rest for another two weeks, so I am
totally in agreement with you here.

> the right people have the issue on their radar again; give them time to
> breath and work out a solution: it's not something that can be fixed
> easily within a few minutes by one person alone, as previous discussions
> have shown (also keep in mind that the merge window was open until
> yesterday, which keeps many maintainers quite busy).
>
> And FWIW: I've seen indicators that a solution to resolve this is
> hopefully pretty close now.

That's good to know. But I must ask, can you provide a link to a public
discussion that indicates a fix is close? Or do you know a fix is close
because of private discussions? That distinction is important to me
because open source software is much less useful to me if the solutions
to problems are not discussed openly (except, of course, for solutions
to security vulnerabilities that are not yet public).

>
> >  After all, it has been over three months
> > since the regression was first reported.
>
> Yes, things take/took to long, as a few things were far from ideal how
> this regression was dealt with. But that happens sometimes, we're all
> just humans and make errors. I did a few as well and learned a thing or
> two from then. Due to that I'll do a few things slightly different in
> the future to hopefully get similar situations resolved a lot quicker in
> the future.
>
> Ciao, Thorsten

Thanks for your quick reply and best regards,

Chuck
