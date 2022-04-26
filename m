Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BBD510224
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352506AbiDZPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352485AbiDZPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:49:48 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB43DAFC2;
        Tue, 26 Apr 2022 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=11sZUzwOjgs+gqwyNHC5h0Ql+65wp5IZuERrTmCmbK4=; b=pG0nlL6azQzK0tOk/EhPcANpAo
        VJqakP9gUhg8WYAEcFCLAUouzbg0YDBYr3chOxbb+Jp1PbU3TTG7KI6OAS34vhSElE3jViDq+njUS
        Sa7LT4uI14w9kJKyFd+IJrjxcdPsEvEV7GiwiLhtnbasXwTrLa/uP/gVVv4sZBr4DQBg=;
Received: from [217.114.218.26] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1njNOe-00013r-7F; Tue, 26 Apr 2022 17:46:36 +0200
Message-ID: <14c5ad61-370b-bcc9-c41c-45312275a0ff@nbd.name>
Date:   Tue, 26 Apr 2022 17:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH -next] clk: en7523: fix wrong pointer check in
 en7523_clk_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com
References: <20220426131539.388382-1-yangyingliang@huawei.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220426131539.388382-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.22 15:15, Yang Yingliang wrote:
> Check the real return value of devm_platform_ioremap_resource()
> in en7523_clk_probe().
> 
> Fixes: 1e6273179190 ("clk: en7523: Add clock driver for Airoha EN7523 SoC")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Felix Fietkau <nbd@nbd.name>
