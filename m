Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF02D52A310
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347453AbiEQNSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347383AbiEQNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:18:46 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 06:18:44 PDT
Received: from smtpcmd10101.aruba.it (smtpcmd10101.aruba.it [62.149.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CCFF41F97
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:18:43 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.66.179])
        by Aruba Outgoing Smtp  with ESMTPSA
        id qx4zn3r0zcKJdqx50nLnQ1; Tue, 17 May 2022 15:17:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1652793461; bh=Im7bn8a6g50JK3DLRhOYV+yX/muSvMy/n6AfP0SgSe4=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=OVztRY5e+Vo5wgr9R2CB53OXd7RMc+lqZ63p8dXb7vn42RVpWUbZxi/LCyGqI1Rli
         I32xy8js5rYtmVCwnqcS1/Aiebq2Mqmrf1j8y9FuwY+Kj4eGa93PlRMaFK/EZSzezH
         ppP3Kf74YsLBgdKoxPLcSHoX7hjZYnyApUcuudOxto316yvmBzBD7WFz4bAUxj+wZY
         nawiMBUinSxt/DomGEoB+TNWOrSdAnufRmBsXn5fB0BnwMw7rMZCROazheFY61UCdX
         RDpGMh8JAsYFebpsKiyax+Aif7H5RxnQm7D3PfTJgtto/17IIA5dkIeLefwc3RzOvk
         3VHKCrHTVNbvA==
Message-ID: <5a01ca81-f49a-a6f5-c80c-4bb8ac5bead8@benettiengineering.com>
Date:   Tue, 17 May 2022 15:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 05/15] dt-bindings: serial: fsl-lpuart: add i.MXRT1170
 compatible
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
 <20220517032802.451743-4-Mr.Bossman075@gmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20220517032802.451743-4-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJoC1DnIsmkpTb3OFMpYCrF2/0Umj6FeZvAjR9UVESNbar/h4sXktlDGKjA68llpEIhr8dv49CFeWUt1wXCB+UndhB9vvyX4ui1NQ7ZNcjTNhx/SRryN
 UiKVsbY8NjUC3PayD/agYb3dNN1eeWRK6mwnGwg2+uDvr4V9bd0PLNqNw+FhxwspAIcDq1uSapJC9GdTic0eXKg6bJ+IFaI9cmcqzuY76K2i6SSRQLa0IVz7
 zUtC4zQ6z/162ORDu0B2Lm5vq12JQyM/NXwwYCmj8XofSqbeNzvudmceTlmZUqwu1cJX+xuYgupDXkB4JwKykQK9KMCiZg3gHVDcsR5krp8x9eFxIZYJ8LBO
 j/zzH2GDz4i6upuJxJrZEjKv8dK44Y4fg8+freEhPRaGsM/23fmo9MwK3ESqihBf2SHE9PyQM1g7GnWJptxuvgTk4zOxQuPVTaCcSqtzS/FK0vmbAge0m5dP
 94gREfP5ufET4qmbX9EeR7Nt0zglEAgyRxNjid9ZMAt7nItoWoDOgoQI7sMysWFVRzyEnbfnlQZkbu1QfvhhpFoUmXRNHsuxFEO48Bzjl1KUoCevReKUjUDO
 Ogznm483V8u+/rxSNWtbgBDuBpw14GAMKmsxJBVK1uAccrOv9UHsHboPebA6tdq+XVmtzgfTI1i/HRjEmBahbVJNfd48/OeVT2mX8hhXEd8l8L+oTUvRtytR
 G6tA4w3wW/lZFbE2e1BdmHg03ROsWCRcD1kymrnIBbSw/uf8BYE0b0vr2lpTYrrYQo3mbI27iGXFnbY7YW0GCPLlMOhwUkL5A/PuyYYtDM+8WajnHU3d7nAr
 h0rejpEE4lHTpmGU9wxBNdUWip8ETBoo139oiMRi0O7WE+NIxXq18gpL64zeureA1HVNuhdzyZ90W0R7GRqIlQJS9Lb83/MB81uQA2gofK/LHdLYWSECChaf
 G8KLH/X4Big95DopvE/AL185nNQOZq5bLogfPVnirfFj/M7/YuSdFXARFkBfiPa1tGXoX3ZwoZ2pMcmkoxCgU/+zKHcVpRnfvL4gYDlZKq/S11fLkWlJoAtH
 zzllnhCy7Z6zrIjSJnSV9fPuwUT4DNcySdDEOa3rPsuQpiiT4w6kfqfFTEFtPuMCUiQj6OXOFPGdeoeoxZ0No6Fq6wpBamCPvaNVgi/Of1anm316qOvpSFDE
 qNZpn2hIiXNm4w5anAJCkS4hqdkawiLYm26UbXKmecOMhgnB6JUG/GYQzJyY0lB/
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On 17/05/22 05:27, Jesse Taube wrote:
> Add i.MXRT1170 compatible string to Documentation.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> V1 -> V2:
>   - New commit to fix dtbs_check
> V2 -> V3:
>   - Nothing done
> ---
>   Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index 30eaa62e1aed..d988d93eb5e6 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -21,6 +21,7 @@ properties:
>             - fsl,ls1028a-lpuart
>             - fsl,imx7ulp-lpuart
>             - fsl,imx8qxp-lpuart
> +          - fsl,imx8qm-lpuart

this ^^^ looks like a rebase left-over

Kind regards
-- 
Giulio Benetti
Benetti Engineering sas

>             - fsl,imxrt1050-lpuart
>         - items:
>             - enum:
> @@ -32,6 +33,9 @@ properties:
>                 - fsl,imx8qm-lpuart
>                 - fsl,imx8dxl-lpuart
>             - const: fsl,imx8qxp-lpuart
> +      - items:
> +          - const: fsl,imxrt1170-lpuart
> +          - const: fsl,imxrt1050-lpuart
>   
>     reg:
>       maxItems: 1

