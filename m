Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC157B936
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbiGTPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiGTPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:10:09 -0400
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322EB289;
        Wed, 20 Jul 2022 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3KSfFl2VG3+nl2ie2xVTPjp2f54MPugBn50jpJsYfJo=; b=XObB/kq1bhuNwm1c6HUL6FB8sh
        z8rOB1C7g4wZvj07laYvfxG2DY2MnojaeTKNmXxzVbcyqeE9V5FZ2kK0YthxP0PYejXXSdrhF1+ro
        hyD1vCQrSq4uXqske8gw5pvlYmf8VDTFLCNO/rBXYYE67bEC9QWnzllLhAgXdwipIlWxGIne6GdWj
        vHs6DqZ0ZZCA8LribtVf1kBTnsEVzd1MOXLbVvlBdFyotRYcyFhfvUUq3vC3QG9wG2OY3AsVOlBx1
        /35s2vkVSpHfXA+G9WpE0gW0l0eQ7cknirPF7GgVOKO4q2j+CRqavBJYBCjuFkfaju/xMjUabCkoJ
        khIejlHA==;
Received: from [2600:1700:4830:1658::fb2] (port=48190)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <david@lechnology.com>)
        id 1oEBCJ-0002vx-FK;
        Wed, 20 Jul 2022 11:01:19 -0400
Message-ID: <0e63b732-57ba-e7b3-3b2e-1e75bebba7d2@lechnology.com>
Date:   Wed, 20 Jul 2022 10:01:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MAINTAINERS: add header file to TI DAVINCI SERIES CLOCK
 DRIVER
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720110026.9173-1-lukas.bulwahn@gmail.com>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20220720110026.9173-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 6:00 AM, Lukas Bulwahn wrote:
> While creating a patch submission on the davinci clock drivers, I noticed
> that the header file include/linux/clk/davinci.h belongs to the section
> TI DAVINCI SERIES CLOCK DRIVER.
> 
> Add a file entry for this header file in TI DAVINCI SERIES CLOCK DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

