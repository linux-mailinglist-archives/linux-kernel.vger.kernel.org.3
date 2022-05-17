Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA3C529718
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiEQCEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiEQCEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:04:20 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A01446165
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:04:10 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 265C31E80D93;
        Tue, 17 May 2022 09:57:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2MPcelc2wIF6; Tue, 17 May 2022 09:57:51 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 878B11E80D80;
        Tue, 17 May 2022 09:57:51 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     rdunlap@infradead.org
Cc:     Kernel@nfschina.com, changbin.du@intel.com, chuanjian@nfschina.com,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH] scripts:modify output format
Date:   Tue, 17 May 2022 10:04:03 +0800
Message-Id: <20220517020404.4195-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <4aeee9a4-e8e1-bcac-1ebb-f2b8860ba363@infradead.org>
References: <4aeee9a4-e8e1-bcac-1ebb-f2b8860ba363@infradead.org>
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

The compiler does not have warnings, but the definition of the output variable is "unsigned int"，So there will be this patch.


