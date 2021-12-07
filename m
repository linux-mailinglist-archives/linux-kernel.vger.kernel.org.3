Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB96446B860
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhLGKHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:07:33 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44250 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231667AbhLGKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:07:32 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B77N2Zr027880;
        Tue, 7 Dec 2021 04:03:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=3jBwxfmb5H1j9Y4065aGPwjoj5+fDbxOpxnZYCYBUI8=;
 b=geRSci6C2gxHPnOH1mWPqO2efkzkvJb/TMafSsbx2IjD8sXTkxI84Lubf9RBbQpAK7hq
 n4yLYju0futPoDgxnjvcHkzlXyWTeT4sRIpq0LGZTvhZQtM3TPPr/8G1oTiUOfhrJWhx
 t/vyIIxTEs9uqYLlU+RfZAwTzHx9hlDUz2fRHg8rjHmBuOl5y5Z+s2har8tu5kSnZTRO
 Tc9DFv+BaFxgvLk1G0BJY4dSp5rx+395hV7UHrSMPeG2qi2Lv0Vc9CF7pD0LpiOXkgk+
 Ao1uyIt2QGWum2K4Mw+zxd4y02DyQVQA1/2EZsUgrYpoO+MXvEUgj3hoeRkGfGT8xcaG 5Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3csbp49nv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Dec 2021 04:03:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 10:03:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Dec 2021 10:03:42 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 926C2B10;
        Tue,  7 Dec 2021 10:03:42 +0000 (UTC)
Date:   Tue, 7 Dec 2021 10:03:42 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH REBASE] dt-bindings: pinctrl: use pinctrl.yaml
Message-ID: <20211207100342.GN18506@ediswmail.ad.cirrus.com>
References: <20211202063216.24439-1-zajec5@gmail.com>
 <CAL_JsqL=4iUJjQXjGc7eacbYW5YE-VRC4yGhu8pLVd-zUKvhHQ@mail.gmail.com>
 <c2afe6fe-d4d2-c9c3-eb36-90969a0b657d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2afe6fe-d4d2-c9c3-eb36-90969a0b657d@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: m3adqQEBD5ecAP5cgU7jn8eRlzygOPOv
X-Proofpoint-GUID: m3adqQEBD5ecAP5cgU7jn8eRlzygOPOv
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:47:38AM +0100, Rafał Miłecki wrote:
> On 06.12.2021 23:50, Rob Herring wrote:
> >On Thu, Dec 2, 2021 at 12:32 AM Rafał Miłecki <zajec5@gmail.com> wrote:
> >>
> >>From: Rafał Miłecki <rafal@milecki.pl>
> >>
> >>Also fix some examples to avoid warnings like:
> >>brcm,ns-pinmux.example.dt.yaml: pin-controller@1800c1c0: $nodename:0: 'pin-controller@1800c1c0' does not match '^pinctrl|pinmux@[0-9a-f]+$'
> >
> >I think you missed some. linux-next now has these warnings:
> 
> Oops, sorry, I think I didn't test MFD bindings *after* modifying
> pinctrl bindings.
> 
> 
> >/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/cirrus,madera.example.dt.yaml:
> >codec@1a: $nodename:0: 'codec@1a' does not match
> >'^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> > From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
> 
> I'm not sure how to deal with this one. If you take a look at
> cirrus,madera.yaml it seems to be some complex MFD that is a sound
> device with pin controller and regulator.
> 
> I'm not sure: is using pinctrl@ node for that hardware is a correct
> choice?

Yeah historically there has been some contention around how to
implement MFD devices, the Madera devices have a single node for
the whole chip, rather than a sub-node for each driver. In many
ways this does make sense since DT should describe the hardware
and hardware wise this is a single chip, the fact linux breaks it
down into separate drivers is really a linux specific
implementation. Although the Lochnagar stuff from your other
patch was steered in the direction of a sub-node for each driver
during review.

But either way the Madera binding is a bit old to be majorly
changing at this point, and does have quite a few out of tree
users. Not really sure how to fix this one either, the name of
codec for the node is really correct as that is what the node is.

Thanks,
Charles
