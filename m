Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF07F49E589
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiA0PNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:13:42 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:22456 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232879AbiA0PNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:13:39 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCt0fA030083;
        Thu, 27 Jan 2022 09:13:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=PODMain02222019;
 bh=/8KV9EG6wZF99drkq+hVaBeISz/7SpcDXvXkAaQbfyk=;
 b=NonAMUlNn2ssEP/XWIohVwtwphTBXFwwfAaSCjpn/9G97UJMq5GF5OMhGZrSalpy2f9o
 pjMouE26p5s1DaS395JyP94XkxDnh/DvdQLvW3uh4JEq/SYjDndnYYvrZeXj7YnOpnsu
 tUnrZ5nbVwSR64+7fsp+Y4MHYz7+O+tKnz3BHE7zqLQgvFa+xrHAk5xZ1Dqx6toEKcSc
 BtwzuayX3WDEiphNRlsA8XDeXIKRvz/2UYDnJMekHn9gAoyrlaxKV/5vlo5eLIpWqkH1
 0qM53NIbIZDHaCK/m4XX9WXGD9T/UpvM5f8Q3c9XzpIgKxXiJ0SkSJw0fYwaOkoNmIfZ Cw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3du0dyhpky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Jan 2022 09:13:34 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 15:13:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 27 Jan 2022 15:13:32 +0000
Received: from smtpclient.apple (unknown [141.131.79.15])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F375045D;
        Thu, 27 Jan 2022 15:13:31 +0000 (UTC)
From:   "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2 0/2] Introduces bypass charge type property
Date:   Thu, 27 Jan 2022 09:13:31 -0600
References: <20220107195806.100956-1-rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
In-Reply-To: <20220107195806.100956-1-rriveram@opensource.cirrus.com>
Message-ID: <02E0F305-CA3A-417E-BD74-C9C4F02D5E11@opensource.cirrus.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Proofpoint-ORIG-GUID: gklpqv9vdUii0lefwycJIpNO-jDhegBB
X-Proofpoint-GUID: gklpqv9vdUii0lefwycJIpNO-jDhegBB
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 7, 2022, at 1:58 PM, Ricardo Rivera-Matos =
<rriveram@opensource.cirrus.com> wrote:
>=20
> Hello,
>=20
> This patch series introduces a new POWER_SUPPLY_CHARGE_TYPE for bypass =
charging
> operation.
>=20
> In fast charging ICs, the bypass operation is used to bypass the =
charging path
> around the charging IC's integrated power converter to its load. This =
allows
> for "smart" wall adaptors (such as USB PPS standard power adaptors) to =
handle
> the power conversion and heat dissipation externally.
>=20
> Best Regards,
> Ricardo
>=20
> Ricardo Rivera-Matos (2):
>  power: supply: Introduces bypass charging property
>  power: supply: bq25980: Implements POWER_SUPPLY_CHARGE_TYPE_BYPASS
>=20
> drivers/power/supply/bq25980_charger.c    | 2 +-
> drivers/power/supply/power_supply_sysfs.c | 1 +
> include/linux/power_supply.h              | 1 +
> 3 files changed, 3 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.25.1
>=20

A gentle bump.

Ricardo=
