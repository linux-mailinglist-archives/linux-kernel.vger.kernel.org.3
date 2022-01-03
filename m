Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCB482F5C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiACJWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:22:54 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20740 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbiACJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:22:53 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2038J5QT012996;
        Mon, 3 Jan 2022 04:22:45 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dbwhb03kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 04:22:45 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2039MiF3034281
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Jan 2022 04:22:44 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Jan 2022 04:22:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Jan 2022 04:22:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Jan 2022 04:22:40 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2039Maul025546;
        Mon, 3 Jan 2022 04:22:37 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/3]
Date:   Mon, 3 Jan 2022 11:21:58 +0200
Message-ID: <20220103092201.21576-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ZuSMYRvAS8LYNllUb_7fjbn-TG24XLzG
X-Proofpoint-GUID: ZuSMYRvAS8LYNllUb_7fjbn-TG24XLzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_03,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201030063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADMV1014 is a silicon germanium (SiGe), wideband,
microwave downconverter optimized for point to point microwave
radio designs operating in the 24 GHz to 44 GHz frequency range.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf

NOTE:
Currently depends on 64-bit architecture since the input
clock that server as Local Oscillator should support values
in the range 24 GHz to 44 GHz.

We might need some scaling implementation in the clock
framework so that u64 types are supported when using 32-bit
architectures.

Antoniu Miclaus (3):
  iio:frequency:admv1014: add support for ADMV1014
  dt-bindings:iio:frequency: add admv1014 doc
  Documentation:ABI:testing:admv1014: add ABI docs

 .../testing/sysfs-bus-iio-frequency-admv1014  |  23 +
 .../bindings/iio/frequency/adi,admv1014.yaml  |  97 +++
 drivers/iio/frequency/Kconfig                 |  10 +
 drivers/iio/frequency/Makefile                |   1 +
 drivers/iio/frequency/admv1014.c              | 784 ++++++++++++++++++
 5 files changed, 915 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
 create mode 100644 drivers/iio/frequency/admv1014.c

-- 
2.34.1

