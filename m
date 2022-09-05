Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602865AD49D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiIEOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiIEOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:18:32 -0400
X-Greylist: delayed 1306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Sep 2022 07:18:31 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D73564D2;
        Mon,  5 Sep 2022 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cSeRxyeOwAya6N44V5TNqcWN8HqSuTOMAR+yUi9raHk=; b=1GDR6mSXHjIsjp6vvCANmOC9Yi
        D9u4cyGWWXpy9+Hby1QewMJMEGjIPXA2J+2nnVYfS08ciQN/LRj1vcV1xg3nlY5NN5nT78X+8lxhu
        e2OO3WdJADpkuPjU9Sx2hDdBU9leX1R6PZvoWiluZbWWGLStnFq6CFfrt3RusNCZgqlV0SjDoFYgz
        t2hRPa5hGEBCPCIU/E4rOFh6++HY7RPc7C/ViOnYo6CTVd0Toq4EwQvWqj0jvrHG3CyePtkLSrYMo
        Xbw97KZEXEaGiCIYOwmRtNE/a4Ww3F03XHN4Ax+A4MxbNknjmclQ0dMSLEv6rpj4QpPL7y2FoYenB
        BfMQ+tPg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36594 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <david@lechnology.com>)
        id 1oVCae-0004vI-Ai;
        Mon, 05 Sep 2022 09:56:42 -0400
Message-ID: <580dfcab-65b8-39a4-6042-36f54e8c7ea4@lechnology.com>
Date:   Mon, 5 Sep 2022 08:56:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: davinci: pll: fix spelling typo in comment
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     nsekhar@ti.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220905065833.1831473-1-13667453960@163.com>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20220905065833.1831473-1-13667453960@163.com>
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 1:58 AM, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

