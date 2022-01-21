Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527E1495A13
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378674AbiAUGlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:41:24 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41052 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348882AbiAUGlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:41:23 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L055gU015220;
        Thu, 20 Jan 2022 22:41:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=8ooxZncd1pxU6VLDFOd0+ogSpakQFSxfdEJz9X266WA=;
 b=RGYBdRzxNajfK608PTgq4Vt69CABZVBErZF2JuEUrk8Cqn1dVby8U2DS+Y50BO8FWqHL
 VmZLQ3w2rksduahhd+n9G+Y7lD/9Ap0iXgZY0nAVPGUcA5nP+J1RxUfo9Wm0U9+qIIv5
 lErbN/P23A6uLFU6NniIPu3DUbJdJq4jGrvPQKguRJSUyijtdzHipf5TzZ+D/nkktck8
 HCAAhWQib4cq75He5kMY8EVyidJAwo/yzc6tlxRg5mNGPqtOepVnNgTnRzcQHZIyL0TI
 aMURX5TtShOFTNGj9jxVyeBoEY81jDJbyI5AVFWxuEryoDj5UYFmgEJvt3emRPgAtISE 9w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3dqhyts03x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 22:41:03 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 20 Jan
 2022 22:41:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 20 Jan 2022 22:41:02 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id 76B553F7097;
        Thu, 20 Jan 2022 22:40:58 -0800 (PST)
From:   Shijith Thotton <sthotton@marvell.com>
To:     <geert+renesas@glider.be>
CC:     <arnd@arndb.de>, <arno@natisbad.org>, <bbrezillon@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <schalla@marvell.com>, <sthotton@marvell.com>,
        <jerinj@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH] crypto: marvell - Fix platform dependency for CRYPTO_DEV_OCTEONTX2_CPT
Date:   Fri, 21 Jan 2022 12:10:57 +0530
Message-ID: <20220121064057.2387263-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7c89454656dd825b38b0364bbb2a849554e6f57d.1641995837.git.geert+renesas@glider.be>
References: <7c89454656dd825b38b0364bbb2a849554e6f57d.1641995837.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 140yYAPDRS-P1qMvWGSoRDh0IqIiMIae
X-Proofpoint-GUID: 140yYAPDRS-P1qMvWGSoRDh0IqIiMIae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_02,2022-01-20_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OcteonTX2 doesn't fall under ARCH_THUNDER and ARCH_THUNDER2. A better approach
would be to define and use a new SOC type as Arnd mentioned at
https://patchwork.kernel.org/project/linux-crypto/patch/266065918e47e8965bb6a0ab486da070278788e4.1641996057.git.geert+renesas@glider.be/
Please wait for him to post that patch or use arm64 as dependency.

Thanks,
Shijith
