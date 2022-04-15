Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F7502749
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351703AbiDOJWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiDOJWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:22:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC741A3AD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:19:36 -0700 (PDT)
Message-ID: <20220415091223.187169221@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650014374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gcgv5zeiqIRSaiKSp0a1+fwmK2z4s1t9rHdQWWn2Loc=;
        b=vL1pn15oLjrFN3pskvPGGs4oD04IcoXsSbMF1+1gSoJABu28Q3AGHkPA/MzRNwG24q4VA5
        Gzp5nylf7ZjRr/Q5ZACNbLlUi51hZlk66gH98HOee+JS0AJwdnLasObfA2ZlEJXdsqqKlC
        /iKy2XqavWIWvsOA5KP4WhLBnBt5dmyV9zkWK1TDI+GebeynTQreMJXnnWoZQ4wC6MpNUM
        iBgZE9lga1jqQ8kRdSXJmjsFgthzPW0k6av8M36ejJhuPV1vR9biWOI4/9Jf9K+dtYYr3N
        b9t3dlPLNp9w50WS9Ds8XcCls7mdU0nfralKBch5TeNm/7SGcMGvG966TprJjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650014374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gcgv5zeiqIRSaiKSp0a1+fwmK2z4s1t9rHdQWWn2Loc=;
        b=CBCofy0SwdkFDjfNQlxeB+LkBJNfLQOCv+7N3FHw7Fvsccm5dvMIG8tuJgfWXbxncRXXB+
        +04beNEdK+GoF6Bw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [patch 0/3] timekeeping: Janitorial updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 15 Apr 2022 11:19:33 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZvbGxvd2luZyBzZXJpZXMgcHJvdmlkZXMgYSBmZXcgbWlub3IgZml4bGV0cyBhbmQgY29u
c29saWRhdGlvbjoKCiAgIC0gQWRkIGEgbWlzc2luZyBkYXRhX3JhY2UoKSBhbm5vdGF0aW9uCgog
ICAtIEVuc3VyZSB0aGF0IHRoZSBjbG9jayByZWFkb3V0IGlzIGFsd2F5cyBpbmxpbmVkCgogICAt
IFJlZHVjZSB0aGUgY29weSAmIHBhc3RhIGluIHRoZSBOTUkgc2FmZSBhY2Nlc3NvcnMKClRoYW5r
cywKCgl0Z2x4Ci0tLQogdGltZWtlZXBpbmcuYyB8ICAgMjQgKysrKysrKysrKysrLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCg==
