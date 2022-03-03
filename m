Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D614CBF0D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCCNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiCCNni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:43:38 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CFB1768E0;
        Thu,  3 Mar 2022 05:42:51 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3746F5801A6;
        Thu,  3 Mar 2022 08:42:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 03 Mar 2022 08:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=KIyWhxM1z3Q8ce
        MBA1Hl4RLFbESpwjDsHE6fD/L0cxc=; b=Fr3e2wqf4UaVl4rIlXtZDOJpeVsZPs
        naVJ4AaJx8n35xSAdNWLE+i+KLk4I+80RC0tM6Q2+67TlXzWJFlld3Y6T4vRYDZy
        /Kbu9Oj38e3Q/s7Szrv42VP6KWl4CFxW3HUiJb3+WXIUuvXlcfsDNWy17peEQg+v
        Crn+UWxfYvWraU/1EY2HU90v/qbsRR3G3eokF26nHch/ErxYXvDhyovQQOCz2s1r
        s1gbsFk39/w8pfnliThwgJCAY3TX6L6eo0kfA+PaLA9qMX1TBAscZNiBrEalTVne
        p9j659tOCy28yd/YTmh8JrRmvQtBTvc+Eh0Fwp62Ofd2JA76vrSz64wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=KIyWhxM1z3Q8ceMBA1Hl4RLFbESpwjDsHE6fD/L0c
        xc=; b=oxHAjRoYMr4ePvpe6LA8ay1nHBPF7bPmBMGmcGVS1OVUyfAdYTFqb/Its
        VTQkURe4SW85ogkpDI2614uZROMl303lkMelCOFUC/lVu+lp50liv6+2lLzD9bp2
        xFet4Z9gHM34jPlS3yyoApqAQcGi50ZwcCOnvt0e6AnPt99K5S+GPwCgvffwWSy6
        3EL7ei4cXUGIxbKCMV5BW87iDgGCyfDg1NFj9tB8uZ7YWhsKRMv2Plxtss0vOHox
        Wvx1iSMHZeCJuQ9oFP7ik3mmOcmLz4EHbWv5QbOyxh5ByKy/RJxrAghO5muDWTbT
        0stMGAC+ThtXMM10hexh8n6J6syTg==
X-ME-Sender: <xms:2MUgYj4r2t7HWfx9tybYNEleUszeIAEkih3snIqVSgPQy4Ru2EZMdQ>
    <xme:2MUgYo453M5dqy6b2Gf0yThWhSKMHNLajErm7IsPtBouhzhwDn3h0weZKZHNzwLwJ
    vm1urfnbg8WmJC4zUk>
X-ME-Received: <xmr:2MUgYqdtwhk4-AEbgWSVsE5drBdjtQipd2VhV5vp2DkGtbWaCvyilHZYEWfVmxXJqKD_4WtCN_otsYaRNGa1IFEPRO0U9WyCcGpmzf-Of3Uh1RnaQg6hdNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtiedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepofgrrhhk
    ucevihhlihhsshgvnhcuoehmrghrkheshihothhsuhgsrgdrnhhlqeenucggtffrrghtth
    gvrhhnpeekfffhfefhteeljeetvdeufeekgfekkeejvefhkeejheegudefgeelvdduvedv
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    hrkheshihothhsuhgsrgdrnhhl
X-ME-Proxy: <xmx:2MUgYkImJNOvftsOq7VXgXZClz2Glir25hoLB0T4p5r93hXrihr2rA>
    <xmx:2MUgYnJa3x2V2GvvLBMhXyg_q7UiEKdrycbfHeHsziuYrOQKt1WCJA>
    <xmx:2MUgYtyKWiEYSM980VsmbCYr040zFt79P6zk-C-ogTFFjvzexT9usg>
    <xmx:2cUgYkBteaBAb2kXqjb_Bw5oUFzoo3-6K2plV8BWGPuY53RBdmVaOw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Mar 2022 08:42:47 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] ACPI / x86: Work around broken XSDT on Advantech
 DAC-BJ01 board
From:   Mark Cilissen <mark@yotsuba.nl>
In-Reply-To: <43b0c275-e728-492b-c6a7-d054fae72117@redhat.com>
Date:   Thu, 3 Mar 2022 14:42:44 +0100
Cc:     linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BBB58DC-653C-4373-A5F5-9239C86C8AE8@yotsuba.nl>
References: <20220302040800.10355-1-mark@yotsuba.nl>
 <832a5b2e-d70c-f1a6-e377-7697b1eb7049@redhat.com>
 <7BD8A71A-95C7-4A10-82FD-BEAAE0B0DDE9@yotsuba.nl>
 <43b0c275-e728-492b-c6a7-d054fae72117@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 3 Mar 4 Reiwa, at 14:38, Hans de Goede <hdegoede@redhat.com> wrote:
>=20
> Hi Mark,

Hi Hans,

> On 3/2/22 21:20, Mark Cilissen wrote:
>>>=20
>=20
> I think that there are a lot more boards that will have
> DMI_BIOS_VENDOR =3D=3D "Phoenix Technologies LTD"
> then that there are boards that will have
> DMI_PRODUCT_NAME =3D=3D "Bearlake CRB Board"
>=20
> So if you want to make the DMI match as specific as possible then
> IMHO dropping the bios-vendor match is best.

Of course, but just to clarify -- my proposal above is to drop

> DMI_MATCH(DMI_SYS_VENDOR, "NEC=E2=80=9D),

not

> DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board=E2=80=9D),

. :-)

Thanks and regards,
Mark=
