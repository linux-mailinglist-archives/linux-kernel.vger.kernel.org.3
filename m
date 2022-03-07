Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC94CFB00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiCGKZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbiCGKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:01:46 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BB71CA4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:51:33 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2270S1sH003599;
        Mon, 7 Mar 2022 03:51:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=jooHwGpfszihrrJZuQ+nipQc96itDDqqbR2sPWXLPrU=;
 b=J+0DTmGrZVSwwC1zliZNMEaJwlH5M0d4XweuPUu3+TgkLnQQnJiki2U2NZ9uB8ysK+j7
 uI3J62Y04+zp8U2ZiUGZGdOsrtGVZ85pyX0oi/hE4rj0/X5jb72N2b0iowjjZ+9HWK2O
 UpR0Kmr953ahKWKxI/U+5An48+fwn6+sP/k4V3wIvL4UcgOSOlS4x4kqFuuO+NOin5/N
 nOpZyP6Japi5O5nH9RRMz7Tqg94qXNwwU7jAC1rjLaiXuWLzEUrHDWGgCRy7Om8ts9UZ
 fQr7RowTz+EtWIuhi7PSm5YoDX2y9r5od1dWSmYC4QyOECn9a972RM/pjSsc9OdLChkL gA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3em55stby0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Mar 2022 03:51:20 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 09:51:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 7 Mar 2022 09:51:18 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C6B4AB10;
        Mon,  7 Mar 2022 09:51:18 +0000 (UTC)
Date:   Mon, 7 Mar 2022 09:51:18 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <trix@redhat.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <orsonzhai@gmail.com>,
        <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: cleanup comments
Message-ID: <20220307095118.GG38351@ediswmail.ad.cirrus.com>
References: <20220305162438.689442-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220305162438.689442-1-trix@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: hX91n6KPd1E_GBl5wrmJ7BQyyNn_SwQT
X-Proofpoint-GUID: hX91n6KPd1E_GBl5wrmJ7BQyyNn_SwQT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 08:24:38AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> For spdx
> Remove leading space, add space after //
> 
> Replacements
> overriden to overridden
> Calulate to Calculate
> addional to additional
> regulatior to regulator
> devive to device
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

For wm8350:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
