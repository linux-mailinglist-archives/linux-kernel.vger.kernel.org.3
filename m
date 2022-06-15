Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E054C9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352231AbiFONd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351648AbiFONdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61AD36326;
        Wed, 15 Jun 2022 06:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44C0461A88;
        Wed, 15 Jun 2022 13:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97C5C3411C;
        Wed, 15 Jun 2022 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655300028;
        bh=GS3xnpuX97rLUj8LjHZuszylSXQMHB8JheJV7wdxaEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rsTfFz33tQEQiFCWsk+brsU8JETQeKOuqDYdhaqxsKFO5Z6TUOv7tKJTcqHPLck3l
         SHQZj1cASBnSPeAc455Suy7V8dAafEvj9jC4P5vpgeRhfeRUCHGDUvjXmuamc78MbK
         tuj2aQhArDpeH7lTVGj5CjaaffmfqxwXj/25Bb9yBq+zirO+rwkGJ9WGLlWylko7T2
         EUtoF1nFceGrKxMW9wMjkQwm7si+P+xEuQn4+rkST0Atb50vlo4oXHhAhxgXOGKzqU
         W7jDla0U9yTzmd1g/N5VkKEICs+KxWnYHnuYpmgAMqlrcCvgA9Gi2rrNG9iPCfQS1F
         7gSLRWBOYBe5Q==
Received: by mail-ua1-f45.google.com with SMTP id m10so4366191uao.11;
        Wed, 15 Jun 2022 06:33:48 -0700 (PDT)
X-Gm-Message-State: AJIora/lJvyVlw04hTl229w20iO5ZkW/scIp2kziuXDH+y9LjYkEXVpP
        A0VvXnOtgRXUFt7Aq36ma4Ul5J8nRjim+F+IYA==
X-Google-Smtp-Source: AGRyM1vl3rEMhCWrfabx4G8UW4agh58YWTqSIPnh7S7BgbjlFbw06IsA0c518VcVDpVFsYVBWjK1QQBn9lCsfe9pDjc=
X-Received: by 2002:ab0:3407:0:b0:379:65f3:a39b with SMTP id
 z7-20020ab03407000000b0037965f3a39bmr4898428uap.63.1655300027658; Wed, 15 Jun
 2022 06:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220615071410.12499-1-piyush.mehta@xilinx.com>
In-Reply-To: <20220615071410.12499-1-piyush.mehta@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Jun 2022 07:33:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+3oS=SB-TVH3JA7Jb8KDgQ8ek_KPJSQhL0mgiq4sjmyQ@mail.gmail.com>
Message-ID: <CAL_Jsq+3oS=SB-TVH3JA7Jb8KDgQ8ek_KPJSQhL0mgiq4sjmyQ@mail.gmail.com>
Subject: Re: [PATCH V4] dt-bindings: ata: ahci-ceva: convert to yaml
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, git <git@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 1:14 AM Piyush Mehta <piyush.mehta@xilinx.com> wrote:
>
> Convert the ahci-ceva doc to yaml.
>
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> Changes for V2:
> - Corrected the patch --prefix V3 to V2.
> - Added Required properties.
>
> Changes for V3:
> - Skip patch --prefix [PATCH V3] as already sent.
>
> Changes for V4:
> - Addressed Rob review comments:-
>  - Update params description
>  - Removed description from common properties.
>  - Deleted deprecated property.
> - Warning generated from: 'make dtbs_check'
>  - Thanks Rob: We are aware of these warnings,
>    but they are unrelated to this patch.

Huh? You are saying the dts files are wrong and should not have
'iommus' or 'phy-names' properties? That doesn't seem likely for
'iommus'. If the old binding was wrong, it is fine to add the
properties in the conversion. Just note that in the commit message.


> ---
>  .../devicetree/bindings/ata/ahci-ceva.txt     |  63 ------
>  .../devicetree/bindings/ata/ahci-ceva.yaml    | 182 ++++++++++++++++++
>  2 files changed, 182 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.yaml

Also, rename to ceva,ahci-1v84.yaml for the filename.

Rob
