Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29654E4F33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiCWJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243310AbiCWJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:22:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3F75C0F;
        Wed, 23 Mar 2022 02:21:29 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22N6MgxC007319;
        Wed, 23 Mar 2022 04:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=dUdn/ajdZpukt6IfviTuwEcR8cl6Pbc9zj4WxhUmKt8=;
 b=dGJg4evumteFBY9L3HnQEPk/QrJyWWGJryeshHcMSyjn+QeWlvdBCEO8rhEcZ3WBFIx5
 TchnIW6s2xbWIdGse8YGxHPfEStWGYZvzvfhosNRUBOeWV5WUdDdQJx1rYHy1yU6I/S2
 Ofzyd8rYeRVBj1Yu146AM0eXgyhX2RBe6N3AQ0FBlJOT9kz1Kjeq1RbjEvO8qH2BRhQx
 3vB6vRBnNeaYUXHiXIBzGiMwdJOuanLBXW/uabAKwLuGari1mu+tuV7a9TMKKq2sNdG7
 mF4g7MSieKAsXS9zeEebPRaE2G4ecOw1bStoif5DX5sldi4U2c2lQ7l+Q0llwAbpi+ha cw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ewbknd5ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Mar 2022 04:20:45 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Mar
 2022 09:20:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 23 Mar 2022 09:20:43 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9023CB1A;
        Wed, 23 Mar 2022 09:20:43 +0000 (UTC)
Date:   Wed, 23 Mar 2022 09:20:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 15/16] ASoC: cs35l41: Document CS35l41 External Boost
Message-ID: <20220323092043.GO38351@ediswmail.ad.cirrus.com>
References: <20220322151819.4299-1-tanureal@opensource.cirrus.com>
 <20220322151819.4299-16-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220322151819.4299-16-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 1BSKhSHDLuiq-vmXuEjJMl83KV1ODsfL
X-Proofpoint-GUID: 1BSKhSHDLuiq-vmXuEjJMl83KV1ODsfL
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 03:18:18PM +0000, Lucas Tanure wrote:
> From: David Rhodes <drhodes@opensource.cirrus.com>
> 
> Document internal and external boost feature for ASoC CS35L41.
> For internal boost the following properties are required:
> - cirrus,boost-peak-milliamp
> - cirrus,boost-ind-nanohenry
> - cirrus,boost-cap-microfarad
> 
> For external boost, the GPIO1 must be configured as output,
> so the following properties are required:
> - cirrus,gpio1-src-select = <1>
> - cirrus,gpio1-output-enable
> 
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
