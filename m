Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BAB586297
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiHACaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHACaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:30:06 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EFE24E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:30:04 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id 125so9893521vsd.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zAz8WQ5PnCeZ7Jnc0tF+mIjzZc6uLMsWR4oH9EyoPM0=;
        b=KHsbUgnizE7Ut1DrkOYeR4rIlmmkbAoaLJoKfhB+gLaLzkOUWuTSTPxsJFQNwmmxZ1
         jBi1Pw+MBP2nh7NwRr97WUtGO9FYKnzCfKvr3nlk9IgNDDN3MdWhRFFgqy3MuUXxeWCb
         rBY7cdsI5aHR4qpAnMKzHYeSO4SHSDn7gTy68g+LZPRotxTo4EcxzlCP1FYSFFN0/BdG
         UvQ7WQrUoAPqjQKhPl5+vUhiv7cPVpsXmhO8SSFw0slAvtpyaCc4ISKHecoc9EFN5qkf
         JtBO2YaA/2N8Z3hyn/gbM0kLDJmktOFQ//VbU6D7n3jHHuWzwhjcARaDNE/MzMHNDVLz
         Gq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zAz8WQ5PnCeZ7Jnc0tF+mIjzZc6uLMsWR4oH9EyoPM0=;
        b=J7yk3zjBBxwVxzC3VJUlM8D6N/zBYM9jI8SkTiO1rFTU2hxDkH40ydSgXC9IqObh+K
         wJ+ztm8vsGwbOD41wq469mtUisM0yk4sjGrWjevATUx0EU8A8U2ox0wMsEUoL8TWb9QB
         18PG+lt7NdclaOH7pB+/3WU4+KTtIiHkjBZgUAenle3ZUQeEwutTP7MJ4AfkZiVq3N8v
         R/6VntBYpGw/c8uroDzxRMQG+dCB3MH/cXtioOqYoAmhFRIZHQn4g6lEruUtkgNNCn+v
         8UMMjI8PlmY1QJ4+/qNEqEN5v32p8Cmlm2XtzX7efqlXVO6a2/CHcSKvuFVO7+NA/jrg
         m8tA==
X-Gm-Message-State: AJIora+dGhjl4U+Y3Ybsw+oHliTuWe0/wqcRimxJNGKcf1J86baF7hrD
        bORIt7Yh8J0eTgZsdoRYuQ6yL1T+Skg=
X-Google-Smtp-Source: AA6agR7M174rgvJaNYVqBsfyIRaCa57Tt7yYela92DNSkO6e6tdQ6s1rg+RUPlDvwSwntGW4qcT6zQ==
X-Received: by 2002:a17:902:e84e:b0:16b:f773:4692 with SMTP id t14-20020a170902e84e00b0016bf7734692mr14499727plg.19.1659320993614;
        Sun, 31 Jul 2022 19:29:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q64-20020a17090a1b4600b001ef9479373fsm10325578pjq.4.2022.07.31.19.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:29:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] comedi:Remove the no effect conditional statements
Date:   Mon,  1 Aug 2022 02:29:48 +0000
Message-Id: <20220801022948.1594777-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Conditional statements have no effect to next process.So remove it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/comedi/drivers/das1800.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/comedi/drivers/das1800.c b/drivers/comedi/drivers/das1800.c
index f09608c0f4ff..2e6dad7b20aa 100644
--- a/drivers/comedi/drivers/das1800.c
+++ b/drivers/comedi/drivers/das1800.c
@@ -1297,12 +1297,6 @@ static int das1800_attach(struct comedi_device *dev,
 			outb(DAC(i), dev->iobase + DAS1800_SELECT);
 			outw(0, dev->iobase + DAS1800_DAC);
 		}
-	} else if (board->id == DAS1800_ID_AO) {
-		/*
-		 * 'ao' boards have waveform analog outputs that are not
-		 * currently supported.
-		 */
-		s->type		= COMEDI_SUBD_UNUSED;
 	} else {
 		s->type		= COMEDI_SUBD_UNUSED;
 	}
-- 
2.25.1
