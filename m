Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3FA58D259
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiHID1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiHID07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:26:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E64D1D0EC;
        Mon,  8 Aug 2022 20:26:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7162F5C00DC;
        Mon,  8 Aug 2022 23:26:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Aug 2022 23:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660015617; x=1660102017; bh=Na1XoX1/pl
        BEkZMRkmfcwe6ezbcEqTuiz3RXzc8G/lo=; b=dahsuqSRcsgQlzXC4GXJeOIzRM
        MbXenQKtGPgGRs4sLNMzJlhdveSh212ppuOi2+RuspySiTUu4luk2Ff7l93ri/n/
        3pivHsyiuwQW4FUDxMl9bnWaIe+VZGye1BZe4B8XtJ2cEXiekzP7rU8a1oWwAYmW
        1Lqr1iM/OzuDRdLDFUfmYB5XRucOz9lfZxSy82to7QgurdPs4WBHRxl+JttZPa72
        e6jUDnxVmELoH+YFv+Wkv4tpSZsBNxXXVQwfppLSAzNwU9060/w/c1R08LG9rsYU
        HYNHJQW3TrdyQtd7Ifen2vr9VntYfleQZe2FzquqBx4W4M5K95qQehoqio3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660015617; x=1660102017; bh=Na1XoX1/plBEkZMRkmfcwe6ezbcE
        qTuiz3RXzc8G/lo=; b=geIR+6yznXYUBqDt2RJImro+xBsTJPP5Vf7XF1Aw2vkJ
        FMP+U9jE9VSxGGP/qIgjMSO3zXJSXxBvpCJ03aJD8PoYK574KeBcwFp18Zd4t85C
        p2TdI0I1OudbO/OWHwibSLLKNTpefwuSCpM9K9Oxh5YfXcUraQIxD41lhbiiVbRD
        j3nOMACr6MeDUDSbby3A6b1+KOZyzKCGqb0qtMBk8qeYUfg/Fm9dWB5Wp8WCR6Lx
        Uvix9YlYvbF3OKFfhmcSJmP2qmt6XeWD4m8qeYuG2njku2oC5rsQTCtR6BpypgFL
        OUivVHdN3osvPREHUT2oUhNQzPp8uo7PQLRXGE6lMw==
X-ME-Sender: <xms:AdTxYoQoyWXLVbywUepTdeAQNhq7Ig0H3xJDQv9h_H8xqge0PsPpuw>
    <xme:AdTxYlz0sirfaVcrz1cA00qCRqirERwPi_pwFTkbW3WjunZH5BNOsMD_2f4CCOQlq
    Dd9z7Jp_MtnFwM-uL0>
X-ME-Received: <xmr:AdTxYl0L7fnQBv9i6EzO_YFXnSEvEiEzwtSNSxjOVx_U8QXQy8xmwA9vnabeOh9WowJfRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:AdTxYsDQwsaFX0z2NOBuG_NMHnHnchg2sN7SrPgIPRnxscc3IMgl7Q>
    <xmx:AdTxYhgmw9WyebHmZwQ0_o-FMcYF0QKWVRqS534X-rc2bPNOss0BWg>
    <xmx:AdTxYopkV8c2LpJ3VeDIXUT3uxTLK3IGJ7tU431FVidpbahq1uRFGw>
    <xmx:AdTxYkveE-nvbWi7GrX2s78KQSGglS1ZInStKbTnRajWIDKkPi_tRw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 23:26:52 -0400 (EDT)
Date:   Tue, 09 Aug 2022 15:26:39 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 2/2] asus-wmi: Add support for ROG X13 tablet mode
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <F8WBGR.2I3OK4ERR79N3@ljones.dev>
In-Reply-To: <CAHp75VcjTG=fFBjjHRYT2+ARfE-VHWKJ9aV8sF4JtRVo7Ke2vQ@mail.gmail.com>
References: <20220808031132.10075-1-luke@ljones.dev>
        <20220808031132.10075-3-luke@ljones.dev>
        <CAHp75VcjTG=fFBjjHRYT2+ARfE-VHWKJ9aV8sF4JtRVo7Ke2vQ@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
> 
>>  -       { KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip 
>> action */
>>  +       { KE_KEY, 0xFA, { KEY_PROG2 } }, /* Lid flip action */
> 
> Have maintainers asked you about this? Otherwise it is irrelevant 
> change.
> 

Fixed

> ...
> 
>>  +                       pr_err("This device has lid-flip-rog quirk 
>> but got ENODEV checking it. This is a bug.");
> 
> dev_err() ?

Okay, changed here and in previous patch to match it.

So that I'm clearer on dev_err(), this doesn't do something like exit 
the module does it? It's just a more detailed error print?

> 
>>  +static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi 
>> *asus)
>>  +{
>>  +       int result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_LID_FLIP_ROG);
>>  +
>>  +       if (result >= 0) {
> 
> First of all, it's better to decouple assignment and definition, and
> move assignment closer to its user. This is usual pattern.
> 

I don't fully understand why you would want the separation given how 
short these two blocks are (I'll change in this and previous patch of 
course, I just don't personally understand it).

Cheers,
Luke.
> 


