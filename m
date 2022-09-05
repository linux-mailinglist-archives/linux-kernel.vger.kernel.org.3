Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAA95AD6E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiIEPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiIEPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:50:53 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBAEF2C128
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=89iLV
        mqmiMdeuT1Shc9ZktsMjIp7qAncJDjv1VIRhDY=; b=GjCx3as+JxNh1EJjz+a2a
        h6rmR93rfhLEtsfs3FVGv3cSvLJ6W5uh4eg8LToHQqQ4JEY6BPtrvryATOkO/adt
        9jbrhmpWa+Yaqy7Eqm3tXh5P6WZfXMcAErLhyJEb0iQXl14HFuf50az4a8sKejf7
        Xzv/cAiinE8abcWkrcoyBQ=
Received: from localhost.localdomain (unknown [180.113.78.212])
        by smtp7 (Coremail) with SMTP id DsmowACXxZi0GhZj9knIAw--.60183S2;
        Mon, 05 Sep 2022 23:50:13 +0800 (CST)
From:   wonder_rock@126.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     ardb@kernel.org, frederic@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 1/1] arm64: preempt: Add NEED_RESCHED to the preempt_count()
Date:   Mon,  5 Sep 2022 23:50:13 +0800
Message-Id: <20220905155013.20118-1-wonder_rock@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905141829.28605-1-wonder_rock@126.com>
References: <20220905141829.28605-1-wonder_rock@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowACXxZi0GhZj9knIAw--.60183S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RdUUUUUUUU
X-Originating-IP: [180.113.78.212]
X-CM-SenderInfo: xzrqvv5ubu0ubn6rjloofrz/1tbiLRdzgVpD-bZ0aAAAsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know it is wrong. I just want to say I think preempt_count() need include NEED_RESCHED

