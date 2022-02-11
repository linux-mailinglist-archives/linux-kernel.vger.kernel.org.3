Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC44B301E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353959AbiBKWJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:09:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiBKWJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:09:45 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5DCF9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:09:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c3so5749296pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=rOmo06AVJ29zMWc+Gwf+ZazCMWJDEtmsXwyKly/OrdA=;
        b=JmqEjOGEN1SqtrKA8Jc0qNhzDy3uTABeBGcmVF1QGaUKAH68SlNnarE4tegrxA43aF
         CeX7RZawOYwtCirX70zUunZQ/rDJmx5pR+zYIQBmvXILllDIYaLlsCon3OVj7VOOVw/n
         j5g5d90+7bFYvTKsmsuLRu9ldP6jpiy0CL2ZqV0zhHaFG7KrG+RBri014wkWgjxSnaFb
         qtdtNdzJLnkCXjfCO2nNpiptQWwoylCDdswvfIwScJr8kTu7B0xqUwD40J572oZa3Gyz
         o8FbNTUzX5Nh2EU/l6lNCnrWNhGHLjm0QMho99C92xU50WqyP5MLTHEowyKL9aiVSCMN
         xU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=rOmo06AVJ29zMWc+Gwf+ZazCMWJDEtmsXwyKly/OrdA=;
        b=lZkoedxxhx9ingNx3eft3lbKSx44qkt5IFgOFEt5Clq88jGeICs7Vwm1urbrLiAyG8
         r0u6k1NRoxhlvG2lFNK1JgT2Cr19Ahxh1p4bgiuppHrujpwQ6mHfDqPIZOkF3TU/NSZQ
         wFYdcKETgEwQPrL5gKowt0ruyZ4bFA83VQLXXtNn85YgTFyUhwn2eAfjP+MZlFbv41z2
         HbbiyvX7UxkTIFdRQNidrukxkjrnNfK9zrfX0a1l4NAnnV2h6q+9gnyXU3jUni3S22xb
         xzCbw83MjxmjiwepffP7/9ndS1ZdVsduNP+vagKUM3IB952Tb2D16L7zekfORvtnpOHT
         kdKA==
X-Gm-Message-State: AOAM531DiZwJRFdBayxufSNIzpMj0RbovdrsSt9JwO6GS0zDVGczZ8qT
        xXG+74crfU9roWxFuPp/W02kEAlUAzyNAg==
X-Google-Smtp-Source: ABdhPJweMnFI9BAH2E1NSs7Lmkb5xcjFIsZNlFquAk+cEZZD7QosUbyPqOKjsAAjA3oEKj8Ftu1eNg==
X-Received: by 2002:a17:902:b414:: with SMTP id x20mr3618304plr.76.1644617382660;
        Fri, 11 Feb 2022 14:09:42 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t1sm28889025pfj.115.2022.02.11.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 14:09:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220208114656.61629-1-colin.i.king@gmail.com>
References: <20220208114656.61629-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] loop: clean up grammar in warning message
Message-Id: <164461738194.23200.14652374197414032855.b4-ty@kernel.dk>
Date:   Fri, 11 Feb 2022 15:09:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 11:46:56 +0000, Colin Ian King wrote:
> The phrase "has still" should be "still has" to clean up the grammar.
> 
> 

Applied, thanks!

[1/1] loop: clean up grammar in warning message
      commit: 65f43c6791944393139078ac853423ed98cca3ad

Best regards,
-- 
Jens Axboe


