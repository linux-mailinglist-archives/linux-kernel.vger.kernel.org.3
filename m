Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6F52ACCF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352980AbiEQUgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbiEQUgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:36:37 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE5813D2F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:36:35 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A0B6E0003;
        Tue, 17 May 2022 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652819794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JO1WKrEanFG8yQlgaFn0gwBkuYo4ZoO0xQro2sEWa0=;
        b=FvZ1BoSTbXyDg5BmODDrgD9qiZyDGZqE6FR0ZjMffAK1ENIX+Na7kDSb8xtrd9ENVsc27F
        EDTNPDZS5y5BM8gCKt5iaUPFhCDuNUD+Zy1ZIVkmxB5BBnkDSmwqP4W521L/SmR0andZyp
        ZZ7XgagcGx/2Z31EgH+i7LdkibU7sJKzOC3DaGVnKdO6O1heQ7veh4Bv43VTWBFHwajU4G
        cwpdoRUjKScAXM24o+XqXjDwu2lBc4f7sU4DbT8FHgjFaCj1+t9Nb8sDnB/sYVf4rQ27SU
        H+tJWqNh9kmKtOcccjYbkXtlPY+ey/nso4PYmw0Qoo4chT8wj5M5ArYdADjcpw==
From:   alexandre.belloni@bootlin.com
To:     cgel.zte@gmail.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        npitre@baylibre.com
Subject: Re: [PATCH] i3c/master: simplify the return expression of i3c_hci_remove()
Date:   Tue, 17 May 2022 22:36:31 +0200
Message-Id: <165281969190.286793.17069630958963159233.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220505021954.54524-1-chi.minghao@zte.com.cn>
References: <20220505021954.54524-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

On Thu, 5 May 2022 02:19:54 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> 

Applied, thanks!

[1/1] i3c/master: simplify the return expression of i3c_hci_remove()
      commit: c157a606e7525409208a51bd6663d6da3757d69e

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
