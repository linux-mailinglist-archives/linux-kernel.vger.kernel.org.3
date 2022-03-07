Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5051E4D0A87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbiCGWG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCGWGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:06:55 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8398B6FE;
        Mon,  7 Mar 2022 14:06:00 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso2683249otj.0;
        Mon, 07 Mar 2022 14:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eN8whrQFP0dYkqOwrVQzZHnY72AuM1tzrD2ytbHKbko=;
        b=XwM7znvFo9IZgXmog0jrq7ch+XnDcJFW7bI2Q3hPRjFYRSIfrDPVIiPHq8Qcks0cUO
         Xq4Z2T6lhpwI0xcaVNM0QxT8LGf0y9I4pM01dyzIdqknQVBCb8Ju3aty95sytwH3oSy+
         dWC2xbtPEI3hadyuJccq5h3luwZfpzROFH1Qh9lN+7kbrYqB+vqSB/8qQfFZ0T2vfvW7
         swdElualzRujtfSYgi3t6tejxNcd6fjmpzaKULkTxQ7SD4PckCF8nuZgl/b/QD0vO8dL
         Rvb/L37n7hyU8mIEjPoUGhlynTT6MhhZtm/UTwOrUfBWqymGpPv7nIn54Q04fIVg3bFz
         WPSA==
X-Gm-Message-State: AOAM533BiSYrxUjBiBBk/AGO10bqxrSXHJ397Fxl8ftBh6Vn0UQ/ar5o
        alC9YFWS85hXDrlr26k3tw==
X-Google-Smtp-Source: ABdhPJzaxyPUrJTHCdqLA7RrZr2+t3jQsud03nitRdse3TmUb7Vuh3JuOoIRO1whdI4e1Ug360NpaA==
X-Received: by 2002:a05:6830:16ca:b0:5af:6a75:c7b1 with SMTP id l10-20020a05683016ca00b005af6a75c7b1mr6716291otr.292.1646690760148;
        Mon, 07 Mar 2022 14:06:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id az10-20020a056808164a00b002d9c98e551bsm2320172oib.36.2022.03.07.14.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:05:59 -0800 (PST)
Received: (nullmailer pid 3324008 invoked by uid 1000);
        Mon, 07 Mar 2022 22:05:58 -0000
Date:   Mon, 7 Mar 2022 16:05:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: Aw: Re: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform:
 Convert DT bindings to yaml
Message-ID: <YiaBxlBkpav/7mug@robh.at.kernel.org>
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
 <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
 <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
 <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
 <trinity-d42352e1-d778-40dd-9464-90a145653f74-1646563315484@3c-app-gmx-bs46>
 <18f4dc19-b8a4-015e-48c8-923326cc7932@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18f4dc19-b8a4-015e-48c8-923326cc7932@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 12:15:39PM +0100, Krzysztof Kozlowski wrote:
> On 06/03/2022 11:41, Frank Wunderlich wrote:
> >> Gesendet: Sonntag, 06. März 2022 um 11:27 Uhr
> >> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
> >>>     add compatibles used together with generic-ahci
> >>>       - marvell,berlin2-ahci
> >>
> >> This is fine, just mention it in commit msg.
> >>
> >>>       - qcom,apq8064-ahci
> >>>       - qcom,ipq806x-ahci
> >>
> >> These you need to consult with qcom-sata.txt. This could be a following
> >> commit which will integrate qcom-sata.txt and remove it.
> > 
> > this depends on Robs opinion
> 
> Then maybe precise the question for Rob...

I would leave qcom separate, but the warnings should be fixed. For that 
you need a custom 'select' schema that lists everything but 
'generic-ahci'. Adding the berlin compatible looks right.

> >> Either you have
> >> binding document for all devices or you create a common part, like for UFS:
> >> https://lore.kernel.org/linux-devicetree/20220222145854.358646-1-krzysztof.kozlowski@canonical.com/
> >> https://github.com/krzk/linux/commits/n/dt-bindings-ufs-v2
> >>
> >> The choice depends more or less on complexity of bindings, IOW, how big
> >> and complicated bindings would be if you combine everything to one YAML.
> >>
> >> In the case of UFS, the devices differ - by clocks, resets, phys and
> >> sometimes supplies. Therefore it easier to have one common shared part
> >> and several device bindings.
> >>
> >> AHCI looks more consistent - except that Qualcomm - so maybe better to
> >> have one document.
> >>
> >>>     increase reg-count to 2 (used in omap5-l4.dtsi)
> >>>     increase clock-count to 5 (used in qcom-apq8064.dtsi)
> >>
> >> This would need allOf+if.
> > 
> > if i get ok from rob i add only the berlin-compatible and skip the 
> > qcom+reg/clock-change in the first applied version. Adding the 
> > allOf/if (and making it right) will only delay the sata-binding/dts-change.
> 
> I don't get what is the problem with delaying this patch for the time
> needed to make the bindings correct? Especially that alternative is to
> add bindings document which soon will need to be modified, e.g. split
> into common part. Is there a particular hurry with these bindings
> conversion?

Qcom doesn't use sata-port nodes, so I don't think there is anything to 
share. And if it did, that's already in sata-common.yaml.

Rob

