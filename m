Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664084676A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380508AbhLCLnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:43:07 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43233 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234517AbhLCLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:43:06 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5298F32019B4;
        Fri,  3 Dec 2021 06:39:41 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Fri, 03 Dec 2021 06:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=lIVxj
        RgVmpfaKrrdsdx/F3lX3DraRx585bzXBwNdx6I=; b=OcBNhk/w+kEnodML7UV2A
        H46ugQ1it+DbQYNb+BXLw26opLiZBftMwySpaG7ktHMHFdDpN0gCoBeWnYCW67Bg
        RFCUx5vUTKve4pL7L7heJPDmFi0uEVbABKU/bStYSVTXk538UzUkWHXkxJhmVOcg
        1ODtn05Y437AsIC7cStZJqGOshqgDa5/sZ4mevWRNQ39wtVNvQeDHmO3O/cCp+OJ
        W6XTH7D1DW+mDPMMrCSOG5OJWM1wFMBjMSR4DF3wXd8c/ngsX2eMdfTeap0biI8F
        oecr8FjDOxWj+iT6agvC+7Ig77oG+x5D97AdnqzLnLuSPE10ePFJfdioNCPmn9e9
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=lIVxjRgVmpfaKrrdsdx/F3lX3DraRx585bzXBwNdx
        6I=; b=bQRAieJdl1Z2uUbFTdS1JeSFE2Lk6ef2HDtdVoMPAntAWemxmVrdpcBqQ
        iSPya2Uv7uhjy+uWnu3RuBoAFKEulS5h7xHPY4tGm9FLVGKyBybV1iie/8C4FwPX
        mjKQPZIZjDbPhnReTT36C6eWJjU3VZu0yxr52XSfXjvJORARXhfLd+U/OguErHvN
        bzz9fnkkvWDH5UrgY+uYNcHZsGDc+FNeVHBfTxb7Tte0J1kZzzs8Qfy499XoBviQ
        GJMYKXXd41junHoasgqyKpB4/QZU/95xf3J4T30ZRk/oBEeRxQy8C2DKFVvMpn0A
        BE0LGulNe7ZKCgWhvAX1jiSH+AosQ==
X-ME-Sender: <xms:_AGqYfyBSerPAvmC5JOWZDrA6wWfEu5OoE0-6N0DHM9FGZqRFMuAyQ>
    <xme:_AGqYXTcWnDmDXr0J-Yj_YBaQzkuDx6SwRXhvuDp5-kixbSlKVo8aXPXEdwnzrzbn
    1By_IaKsYjTujU-EFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_AGqYZVtEEPjaWOfYguK2pwofuh9lledXlw62yoAMLmG5G3FSg73fw>
    <xmx:_AGqYZjysdD_qU16fMBm3CDelUFrwABoTVI3kpkESPv2RH51ZfChYg>
    <xmx:_AGqYRCfHGzujMDXeJiKgrmLOYkryHjJOuEMoHjncZehgdu78nwIIA>
    <xmx:_AGqYbBrxJNEUpTyFMd8bzzxUl18Uoct23OP2ajvCgDWGVXmAhg2hA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EF388FA0AA7; Fri,  3 Dec 2021 06:39:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <57665273-e56e-4b66-9dbd-003d592eb65d@www.fastmail.com>
In-Reply-To: <343c2c64-4d0b-6e21-80e0-834d0b7147aa@intel.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
 <20211203003636.11417-8-jiaxun.yang@flygoat.com>
 <343c2c64-4d0b-6e21-80e0-834d0b7147aa@intel.com>
Date:   Fri, 03 Dec 2021 11:39:19 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Dave Hansen" <dave.hansen@intel.com>, x86@kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        "Jiaxun Yang" <j.yang-87@sms.ed.ac.uk>
Subject: Re: [RFC PATCH 07/10] x86/fpu: Rellocate fpstate on save_fpregs_to_fpstate
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82021=E5=B9=B412=E6=9C=883=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8A=E5=8D=8812:44=EF=BC=8CDave Hansen=E5=86=99=E9=81=93=EF=BC=9A
> On 12/2/21 4:36 PM, Jiaxun Yang wrote:
>> --- a/arch/x86/kernel/fpu/core.c
>> +++ b/arch/x86/kernel/fpu/core.c
>> @@ -112,6 +112,22 @@ static void update_avx_timestamp(struct fpu *fpu)
>>  		fpu->avx512_timestamp =3D jiffies;
>>  }
>> =20
>> +/* Update xstate size if it more dynamic features are opted-in. */
>> +static inline void xstate_update_size(struct fpu *fpu)
>> +{
>> +	int err;
>> +	struct fpstate *fpstate =3D fpu->fpstate;
>> +	u64 fpsmask =3D fpstate->xfeatures;
>> +	u64 curmask =3D fpsmask | xfeatures_in_use();
>> +
>> +	if (fpu_state_size_dynamic()) {
>> +		if (fpsmask !=3D curmask) {
>> +			err =3D fpstate_realloc(fpu, curmask);
>> +			WARN_ON_FPU(err);
>> +		}
>> +	}
>> +}
>> +
>>  /*
>>   * Save the FPU register state in fpu->fpstate->regs. The register s=
tate is
>>   * preserved.
>> @@ -129,6 +145,7 @@ static void update_avx_timestamp(struct fpu *fpu)
>>  void save_fpregs_to_fpstate(struct fpu *fpu)
>>  {
>>  	if (likely(use_xsave())) {
>> +		xstate_update_size(fpu);
>>  		os_xsave(fpu->fpstate);
>>  		update_avx_timestamp(fpu);
>>  		return;
>
> Have you considered what exactly happens when you hit that WARN_ON_FPU=
()
> which otherwise ignores the allocation error?  Have you considered what
> happens on the os_xsave() that follows it immediately?  How about what
> happens the next time this task runs after that failure?

Thank you for the catch.
This is a few questions that I don't have answer, so it's a RFC.

I thought it is unlikely to happen as kmalloc has emergency pool.
But in case it happens, I guess the best way to handle it is just
send SIGILL to corresponding user process or panic if it's kernel
fpu use?

Thanks.
--=20
- Jiaxun
