Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725D567B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiGFAsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 20:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGFAsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:48:53 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01DD4167D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:48:51 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B366F1E80D40;
        Wed,  6 Jul 2022 08:46:40 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0-1CPv_Kj2np; Wed,  6 Jul 2022 08:46:38 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 0F5301E80CDE;
        Wed,  6 Jul 2022 08:46:38 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     samuel.thibault@ens-lyon.org
Cc:     chris@the-brannons.com, kirk@reisers.ca,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        w.d.hubbs@gmail.com, zeming@nfschina.com
Subject: Re: [PATCH] accessibility/speakup/speakup_acnt: Add header file macro definition
Date:   Wed,  6 Jul 2022 08:48:23 +0800
Message-Id: <20220706004824.2966-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220705111621.smcxnfx45ai7vixy@begin>
References: <20220705111621.smcxnfx45ai7vixy@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you very much for your approval. 
I continue to add macros to speakup_dtlk.h and any header files I could add.

