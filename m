Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760884856D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiAEQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiAEQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:48:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A97C061245;
        Wed,  5 Jan 2022 08:48:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 942CBB81C98;
        Wed,  5 Jan 2022 16:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413E4C36AE9;
        Wed,  5 Jan 2022 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641401277;
        bh=KkkxiAe5xaMqvNuhNFkYY1SOHR4Fhz8f0sfjDPYzRs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M3WflBaElaz1VpNs7i2pUiOSurTgEM1BvxAmfM1NCCi1HCoeU9fs7+BNvNLAeA1dR
         DPnrCX0ycgPJsKWm58dHmNjJU228QEHVAV//IcXJddy8DQ+2OdaKDCWbybua10Qurm
         F86BPBbr6QE6Ghbomkv2Q8Zc2tGBA1kR2M79umkpgk0mfvUEmHqs5wW5sOcRMQQdui
         TAZi+e0BIYPd6VKRQ5GMYrGzUAakntSHXXQqL5wPnz+pPVzvJLHi54WK3i3SboAJs2
         uVtJXxItEw3253fbJZFovM3XhB3UW3CqrPyo4/mWXpsMSVEsdEscOPX1VBY+FL8VXG
         jTniyWH00lkTQ==
Received: by mail-ed1-f53.google.com with SMTP id o6so164520322edc.4;
        Wed, 05 Jan 2022 08:47:57 -0800 (PST)
X-Gm-Message-State: AOAM530bmARemRxroVwWRMUWLyFEtln83HVRvuDwohJ3zlu/GXxZyohB
        xfxZQIJYA5Bq1XTEhFSVhk6ZtjbHxN0UP3KUGw==
X-Google-Smtp-Source: ABdhPJyxjRkqLpooiXPRquUmsgEwwYE6rqtt44FwsBsxebTlGRcHn/lUNboqY0srr5DyCQaqwvBG9pvPQDtRmS627Ws=
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr42083173ejc.14.1641401275538;
 Wed, 05 Jan 2022 08:47:55 -0800 (PST)
MIME-Version: 1.0
References: <YbufNsBtiIzbm+9k@robh.at.kernel.org> <20211217144544.7147-1-akingchen@vivo.com>
In-Reply-To: <20211217144544.7147-1-akingchen@vivo.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Jan 2022 10:47:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKnGj0ocLS6sOc2aryh4QwQqbO8Zo4CctgfYYWTnbmxNQ@mail.gmail.com>
Message-ID: <CAL_JsqKnGj0ocLS6sOc2aryh4QwQqbO8Zo4CctgfYYWTnbmxNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: usb: document snps,dis_split_quirk
 property in dwc3
To:     Yaqin Pan <akingchen@vivo.com>
Cc:     Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@vivo.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 8:46 AM Yaqin Pan <akingchen@vivo.com> wrote:
>
> >> >> Add snps,dis_split_quirk property for dwc3 controller
> >> >>
> >> >> Signed-off-by: Yaqin Pan <akingchen@vivo.com>
> >> >> ---
> >> >>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
> >> >>   1 file changed, 6 insertions(+)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> >> index 41416fbd92aa..e9615ca8f447 100644
> >> >> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> >> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> >> @@ -226,6 +226,12 @@ properties:
> >> >>         avoid -EPROTO errors with usbhid on some devices (Hikey 970).
> >> >>       type: boolean
> >> >>   +  snps,dis_split_quirk:
> >
> >I'm tired of the never ending DWC3 quirks. Imply this from the
> >compatible unless it varies by board.
>
> Yes, this is a DWC3 controller compatible issue.

Again, imply this from the compatible STRING (or the compatible string
of the parent node). I don't really want to see more quirk properties
unless they are board or instance specific (meaning for a given SoC,
the setting varies).

What is the downside to always setting this bit in the controller even
if not needed? Answer that question in your commit message.

Rob
