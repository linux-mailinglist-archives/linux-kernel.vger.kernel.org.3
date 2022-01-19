Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE449390E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353619AbiASK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:57:52 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49464 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353668AbiASK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:57:46 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J6NBrK017491;
        Wed, 19 Jan 2022 04:57:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=fOd222qY8xZt0sg7OGdoy04bGSodL6nFPzOgMbRa1G4=;
 b=iJypDQ4rcSbFTEMf4Kl1ljABSmZ/tvIyRJ6/kSQ0OcOOxyhvteEpXAtZuRTTBgDvPHJX
 tdU/SjaheiT08h7J/A5ey6BMeKgInf1xj9TCYL7/atalTnJoosmCsA1N1mOulJd9ygKM
 TS+U1wPR/ZdUby4zsdj/5zDXibkJbLfWzpZSmf65dzY3VaEAAWpmQym7nHbCKEfO8paL
 aMoOMjVVXFTwxRCgNFFP+hufxLOf0qrOw+/UoDM15UJYxuCwpWFy9P+0yUQOZy8b4wJo
 GxRuwdq/Dl537kXz+sGZVN87qVhrTyArxoLAQ/oYxl4sP6Llz6Ida6J9j9IDyFv98KN4 1A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhtd5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Jan 2022 04:57:40 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 10:57:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 19 Jan 2022 10:57:38 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F3B63B0E;
        Wed, 19 Jan 2022 10:57:37 +0000 (UTC)
Date:   Wed, 19 Jan 2022 10:57:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        - <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: cirrus,madera: Fix 'interrupts' in
 example
Message-ID: <20220119105737.GR18506@ediswmail.ad.cirrus.com>
References: <20220119015611.2442819-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220119015611.2442819-1-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Mig959vrEYaqbN-En9rsDQkWcnIQfM7B
X-Proofpoint-ORIG-GUID: Mig959vrEYaqbN-En9rsDQkWcnIQfM7B
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 07:56:11PM -0600, Rob Herring wrote:
> The 'interrupts' properties takes an irq number, not a phandle, and
> 'interrupt-parent' isn't needed in examples.
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
