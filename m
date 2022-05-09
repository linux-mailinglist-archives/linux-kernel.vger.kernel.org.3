Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1187451FD57
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiEIMvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiEIMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:51:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED42A1507;
        Mon,  9 May 2022 05:47:44 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249CMgoR007788;
        Mon, 9 May 2022 07:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=eOjjoMvRWvPpJ0hgClKMj0YsMUCFEr2/e90Xg0pSWtc=;
 b=KGbxUnqIdH0739XcMRkFLgwYkKsQo6q7eMu94+3SdRTjLbO8oqeuzKGqs38vN+NHgOEw
 3Ak7N3Bs9lnVUw+hDfTIiI1SPqxzuoguKD6eOCjfjbIDN8RhrEe9ApWnxP//tfgD3GiK
 aUgDirOehm3TeO0/pbBoHLLTy3ub+3l2C9uKc4ewHxRYcVJSEmqyPhJDMR3xMz18+A+t
 Qj45JD+nYr94u9XXAmi40KprhYvDhfhyYvj6HcqwDAK2a9v4XD/dirlW4zl81aVhgCIw
 CcACB1v+WbBlhu5YwbvkosI89dKz7hkw/HyJPxLivx1dEcZ1fczEUZ3R5klNSH9/l9Tf Ow== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fwp612wu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 May 2022 07:47:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 13:47:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 9 May 2022 13:47:25 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 568C1B10;
        Mon,  9 May 2022 12:47:25 +0000 (UTC)
Date:   Mon, 9 May 2022 12:47:25 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lukasz Majewski <lukma@denx.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] doc: dts: Add device tree information regarding
 wm8940 codec
Message-ID: <20220509124725.GZ38351@ediswmail.ad.cirrus.com>
References: <20220509121313.31216-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220509121313.31216-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: JE-tmVTuy_8_kQ0V8bl-RjpqShAy531Q
X-Proofpoint-ORIG-GUID: JE-tmVTuy_8_kQ0V8bl-RjpqShAy531Q
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 02:13:13PM +0200, Lukasz Majewski wrote:
> This commit provides documentation entry for wm8940 codec.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
