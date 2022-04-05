Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1544F4112
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448107AbiDEUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442575AbiDEPhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:37:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113514D020;
        Tue,  5 Apr 2022 06:52:16 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2356WHiA029192;
        Tue, 5 Apr 2022 08:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=qdlWSFWox8pqXhYTtt1fv3TfdyVH568avS9AMQTckt4=;
 b=PKbbBxLzsWnf3sZ3Gb91O1NnBu3X2FULdZyghJt+k/ySFZWpnEJbBhbq3OGlAckgvwzj
 GSY32edVAbCt+8WDbEuthhPwyhh2VLkwRz7eC7+wj9z0mXrj0Nqit67eYGvis5eK9qtD
 xmXrhvWrLiUnjygcvGcULUAX++Jv6U5i5hjIx3B6mUT4z9RzQao796w8nGlH0Wv+9A0e
 VQSVnANh6o6STWuVZEYWgUNYi8EWGYSyHqamITND2wrQENPTL3CWb9s2DlX6vkN92/An
 QcsFqq5zfOSs9WlKVqrekcZaRQ/0XCP28EhXuIcEADfYJanV/5toBpTefgsqZJjh+Wph EA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3f6jwnujw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Apr 2022 08:51:59 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 14:51:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 5 Apr 2022 14:51:49 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EFB40458;
        Tue,  5 Apr 2022 13:51:48 +0000 (UTC)
Subject: Re: [PATCH 5/5] ASoC: cs35l45: Add driver for Cirrus Logic CS35L45
 Smart Amp
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20220318162943.1578102-1-rf@opensource.cirrus.com>
 <20220318162943.1578102-6-rf@opensource.cirrus.com>
Message-ID: <b9059240-fe6b-6549-d22d-de4bc2ab0c85@opensource.cirrus.com>
Date:   Tue, 5 Apr 2022 14:51:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220318162943.1578102-6-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1Q4LWg2XrZQXUi0dgcuoSCeoh3Ub3r62
X-Proofpoint-GUID: 1Q4LWg2XrZQXUi0dgcuoSCeoh3Ub3r62
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 16:29, Richard Fitzgerald wrote:

> +static int cs35l45_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{

Use the new .probe_new callback

> +static int cs35l45_spi_remove(struct spi_device *spi)
> +{

This is now a void return
