Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84A755389A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351787AbiFURLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiFURLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:11:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF9252B7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:11:42 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LBPIlq007338;
        Tue, 21 Jun 2022 12:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=zDQ6GqXPGfrimhD4YgdQPLhNjpqeT4KNBIe2LvxDde0=;
 b=ZlvqUof0O3JHa37dG1ErPk5I9vsN1NDH/u5TxkE0hL6ChBK/cHYnUOST22fYhfgaZUs1
 HXu+CJHymtECTeFmrZeS1oyeBtkCouERVjhsW/KWWB6i9HVvqppVkrSO/botusxUmeSh
 fwzL4FMJr9Y7Yl4uQPP3KK4aUxIU+BGFPlRx7Ig1BCW9NlqUecIoluRiV3zsQeXwqmfH
 JNrcsgXfugEW+hYkGR0aBXe1d498EpAuUDArOTjEW7YR3rSVYmX3QYdqrVQKVTY+TaFx
 3fG07v92OiWfpKdFbhJP3YVWMBaW/OJC891MEgfw4iQLTE3RamgZSnXUckX0zY19aamI eA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41bx2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 12:11:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 18:11:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 21 Jun 2022 18:11:33 +0100
Received: from [141.131.206.39] (david-linux.ad.cirrus.com [141.131.206.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A77DE475;
        Tue, 21 Jun 2022 17:11:31 +0000 (UTC)
Message-ID: <06b02d51-6915-d56f-51e6-94a3fd182bc4@opensource.cirrus.com>
Date:   Tue, 21 Jun 2022 12:11:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] ASoC: cs35l41: Correct some control names
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <lgirdwood@gmail.com>, <david.rhodes@cirrus.com>,
        <james.schulman@cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20220621102041.1713504-1-ckeepax@opensource.cirrus.com>
 <20220621102041.1713504-3-ckeepax@opensource.cirrus.com>
From:   David Rhodes <drhodes@opensource.cirrus.com>
In-Reply-To: <20220621102041.1713504-3-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: exPQh_68I1CYLfWJkVVshTwYPeURyIev
X-Proofpoint-ORIG-GUID: exPQh_68I1CYLfWJkVVshTwYPeURyIev
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 05:20, Charles Keepax wrote:
> Various boolean controls on cs35l41 are missing the required "Switch" in
> the name, add these.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Acked-by: David Rhodes <drhodes@opensource.cirrus.com>

Thanks,
David
