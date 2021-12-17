Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D16478A14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhLQLfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:35:00 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:6082 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231717AbhLQLex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:34:53 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BH8OJiB016240;
        Fri, 17 Dec 2021 05:33:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=qQFrIlpFszZ1RBg9pe9JzRRyFu+mammDM6kqccfXLE8=;
 b=Yg+MvWuvysTVkyIgfPcJ5PQtMnreTVx82mpk3ZiP8ycfdJdl/WRhkDSEycI4U7OpTenz
 zxkYqASWtupMkWASRAYLb/xgBjF7UlAFFFPI6VGaknAcc5t4+6sYDRNkjgiNjQjEBabZ
 tTUgzBOilnmmA3TwDlMDQLi40TDhzCnLPi/QXNxz20VkZ/iUDQQUtL/AcVs7ZIu4XBBo
 ETX8cPnerazAewrqi7UbsS31QohDCX0EagbjjcWjgoTLYMHjgin5DR8G/+ErZEI3zAaD
 TcFfoQKwUZ4VO9SoqrNq69Fyuk9W3AG9aWeWfpDXeNozq+YS/G/kJIEr4lTe+hAvZ9Rr zQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3d0q0m05wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Dec 2021 05:33:41 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 11:33:40 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 11:33:40 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 96C10478;
        Fri, 17 Dec 2021 11:33:39 +0000 (UTC)
Date:   Fri, 17 Dec 2021 11:33:39 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH v3 1/1] pinctrl: Propagate firmware node from a parent
 device
Message-ID: <20211217113339.GV18506@ediswmail.ad.cirrus.com>
References: <20211216151227.58687-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211216151227.58687-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: nzCZZVgiqNxCMOFILECwBs6o2giAwtqQ
X-Proofpoint-GUID: nzCZZVgiqNxCMOFILECwBs6o2giAwtqQ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:12:27PM +0200, Andy Shevchenko wrote:
> When creating MFD platform devices the firmware node is left unset.
> This, in particular, prevents GPIO library to use it for different
> purposes. Propagate firmware node from the parent device and let
> GPIO library do the right thing.
> 
> While at it, slightly modify the headers to reflect the usage of APIs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

For the Madera bits:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
