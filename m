Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B474758F835
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiHKHRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiHKHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:17:42 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 551BD785A4;
        Thu, 11 Aug 2022 00:17:39 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id A97921E80D76;
        Thu, 11 Aug 2022 15:15:36 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sd49OkeV2EuA; Thu, 11 Aug 2022 15:15:34 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D8DDD1E80D32;
        Thu, 11 Aug 2022 15:15:33 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     ebiggers@kernel.org
Cc:     chuanjian@nfschina.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, kernel@nfschina.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/drbg.c:remove unnecessary (void*) conversions
Date:   Thu, 11 Aug 2022 15:17:32 +0800
Message-Id: <20220811071733.5145-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <YvKiRWzWyATdEwGP@gmail.com>
References: <YvKiRWzWyATdEwGP@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


v2:
Turn assignments less than 75 characters into one line

