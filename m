Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B1595878
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiHPKgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiHPKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:35:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B81BBA69;
        Tue, 16 Aug 2022 02:06:41 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G1cRYr013154;
        Tue, 16 Aug 2022 04:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=V7+EmkrSuZ84Bb1gS/wxH1FOr6TUaRrdnHDtztrgSTo=;
 b=hDeJAig6BJnBTD5z4jiBt1IdQiSF3hjYucAxgdiRHbbX9J7cMmMBxy78RMBBQFj4J1O+
 rToQ/FZui015D/7EUuAA/s83U3/Ci89croC9zkjR6NzuvELgsRAluF5vkg+ofgMikp0h
 CI9vVF4KiolPUQqymIcCtNJhyelnl+DOOjhxRIn6Qt8ESg7FGxee9UR5w9nc6Jq7GK9Y
 JyQe6K3vwTCiRBTViHq0/pt8n1GzXaChw/SvNx+Fuft8zbRw4J0JGUPKsZyp5XWnqwhp
 QcwFDv62Q3rlE4Bsp6CEWKALJTuoBaK7NSn8gdNzVUxa1yLdtghmiFB75X8Dez3aif0Y zA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpbav1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 04:05:55 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 16 Aug
 2022 04:05:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Tue, 16 Aug 2022 04:05:54 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5A7F57C;
        Tue, 16 Aug 2022 09:05:54 +0000 (UTC)
Date:   Tue, 16 Aug 2022 09:05:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: Fix the include guard used for
 include/sound/wm8904.h
Message-ID: <20220816090554.GJ92394@ediswmail.ad.cirrus.com>
References: <eff524b78d1f851e3dc42999e68c286492f92b21.1659800938.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eff524b78d1f851e3dc42999e68c286492f92b21.1659800938.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: Cv0SVka0lPbtKA-6rDUgNcbQ73hqUg6g
X-Proofpoint-GUID: Cv0SVka0lPbtKA-6rDUgNcbQ73hqUg6g
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 05:49:14PM +0200, Christophe JAILLET wrote:
> __MFD_WM8994_PDATA_H__ is already used for:
>   include/linux/mfd/wm8994/pdata.h
> 
> Based on file names, use __MFD_WM8904_PDATA_H__ instead here.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
