Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC93D5A7D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiHaMRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHaMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:17:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5B8CEB3F;
        Wed, 31 Aug 2022 05:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F700B82059;
        Wed, 31 Aug 2022 12:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3102C433C1;
        Wed, 31 Aug 2022 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661948264;
        bh=CO+Sz7LAJhdsmtQMBf/CpZLDa2m+oXHpOG6EDh1zmv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ix2sbtIBzo556qH7pgNCD9Cr0dYRk9diX5SWzbci9PwaW/s4qWcDENqH7q5rvJ/RU
         Vhh1Bzwfn/RMIuxj39XtdPwkbaziHjGnkkwNeuR7ZwUqu4xnBiVUCWeva28JbW914B
         +6t9wjTRrGq1KVuE3sXH2FyNqzbz3aiQ43ZJgWVi+U1YTNKtulM9quwmgZAIHfNFYs
         lLDe4d6LSQW/l8Nx/rgsqawP5/ujTO27EIasS1ue703kGThJhnxgOPf8+7HYjQadqP
         Zed0pvPZwGK3bMWKZNXePDOuL2vJ9nbUPe8XaSOmUSF+zNKtsgnkp7p7NpofSMhT/B
         MNZRaFAHssR2A==
Received: by mail-vk1-f175.google.com with SMTP id b63so3131717vkh.5;
        Wed, 31 Aug 2022 05:17:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo1mbFoVAY798+9UR9ZxJ4SdFbodODm6ZW4/Wv+zvnoqgkESyHK/
        Zvc2YVH2NSmXxyJwgmGGzbzbMREbH/aq4aPxIg==
X-Google-Smtp-Source: AA6agR7vvn/itEutl10ZadIATfvb5bAUwUWEVlOfeioy9JowfYkjnkIVaB6v1NfPHZMIpmdFmA/1ZfBJp7unYIhxXbA=
X-Received: by 2002:a1f:2416:0:b0:37c:382c:912a with SMTP id
 k22-20020a1f2416000000b0037c382c912amr6979458vkk.12.1661948263818; Wed, 31
 Aug 2022 05:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220830192212.28570-1-farbere@amazon.com> <20220830192212.28570-9-farbere@amazon.com>
 <1661945961.480039.3614528.nullmailer@robh.at.kernel.org> <a8557b5a-6e27-2e66-161e-814fc0f69c1d@amazon.com>
In-Reply-To: <a8557b5a-6e27-2e66-161e-814fc0f69c1d@amazon.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Aug 2022 07:17:32 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+c7DaJFCgeHDsXQT8oqHmPS57S-o_EALz=nHDREhqc7g@mail.gmail.com>
Message-ID: <CAL_Jsq+c7DaJFCgeHDsXQT8oqHmPS57S-o_EALz=nHDREhqc7g@mail.gmail.com>
Subject: Re: [PATCH v3 08/19] dt-bindings: hwmon: (mr75203) add "moortec,
 vm-active-channels" property
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     almogbs@amazon.com, Rahul Tanwar <rtanwar@maxlinear.com>,
        Talel Shenhar <talel@amazon.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        itamark@amazon.com, amitlavi@amazon.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, shellykz@amazon.com,
        Jean Delvare <jdelvare@suse.com>, shorer@amazon.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, dkl@amazon.com,
        "Hanoch, Uri" <hanochu@amazon.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 6:53 AM Farber, Eliav <farbere@amazon.com> wrote:
>
> On 8/31/2022 2:39 PM, Rob Herring wrote:
>
> On Tue, 30 Aug 2022 19:22:01 +0000, Eliav Farber wrote:
>
> Add optional "moortec,vm-active-channels" property to define the number
> of active channels per VM.
>
> This shall be useful to avoid exposing sysfs for reading inputs that are
> not connected to any voltage source.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V3 -> V2:
> - Add "moortec" prefix to property name.
> - Add explanation why this change is needed.
>
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> I used dt_binding_check on my changes (I ported it to my kernel).
> The error is related to "intel-vm-map" which I did not add.

The error is the vendor prefix is not defined in vendor-prefixes.yaml.

> I don't mind fixing it if you wish.
> It requires changing:
>   intel,vm-map = [03 01 04 ff ff];
> to:
>   intel,vm-map = /bits/8 <0x03 0x01 0x04 0xff 0xff>;

That is not the issue. The issue is the type is unknown because your
schema fails and we can't get the type from it. Once your schema
passes, this should go away.

Rob
