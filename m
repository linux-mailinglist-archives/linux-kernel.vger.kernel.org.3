Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF05A45C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiH2JN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH2JN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:13:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CB5A83E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:13:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 12so7166439pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cK9gFkwcVqBLXSkw4yJqMZFLcyT936UDHTKjLWRpM7c=;
        b=kf8UdLoG7Ht7Jcb3/PwyD5CLqoyET5/HlWgYtG5WpoUpvw2y3rGpYhi7JPKNsP5rV2
         HVsoRX5Aq0mJOlV7CW8EyK1jp95z98f+M3haosjwWfbuiHPAARSOug3neRY7sVY0mBVi
         +WQtKj8SbTnVEST48gH+/d8O2nQqEhKi+7AWUw+FubjiaJHuO0dv5o1zg1A0RF8qfnIn
         mjuXfJ1b7Hsye9aM2jT5enJcXeoXp0MHwtALIIjDVxzlX3izmO86qANgFGFSIPfTR+t/
         8mFphPXLzKaf+a7RAUthjwk7IpSgpxwzObk3EOKItmW1w5cqSj7ZzAnq5FdwDa1bF+L+
         tYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cK9gFkwcVqBLXSkw4yJqMZFLcyT936UDHTKjLWRpM7c=;
        b=r1iqMO6+TJPULogBo5XVNIwBqrGMIYshUqaeoSKRkpGM8YuFe7r5HORZBbfhnhKe8E
         /7eRYvlhM5PbwTteB3YFZwPKCmga7IbFlHvqEzthzASbNxYvK0K0baR+gIcGKpSAZU1y
         73zMjUAj9CLzpwUBm0YVKZiC/r6+GHSoFz4rjx44feJ8W0o0H1U2/6csMrISNt+/xkz0
         HCW+93oenPBnnZyav4RTFshdopfWCb2cvksdvs0VZ6lu/4FJHZt30mpKm9sSo8M+Oqun
         sodEkILsMd345mff2IGn53mpmU7wzPUaxlj5mYRZ9hluVJ8PF0Uo1M0JGdpDILRvM6uY
         xJiA==
X-Gm-Message-State: ACgBeo2p1y1ea2tURT1TO7N8NcNwcVLKcLZesMLu6aIftQCWb88YvOMG
        y0nlmGiTYVDxE908kdxJp3s=
X-Google-Smtp-Source: AA6agR6AGSiG4FoJKYvBtVFtKdgps4YVa0oOGS+yvyvkUiJcgqSc1EL4lEKJSItJS+Bt63snYd74zA==
X-Received: by 2002:a05:6a00:2787:b0:537:d9b1:f942 with SMTP id bd7-20020a056a00278700b00537d9b1f942mr12615968pfb.30.1661764406193;
        Mon, 29 Aug 2022 02:13:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r4-20020a63e504000000b0041c66a66d41sm5982280pgh.45.2022.08.29.02.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 02:13:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        tommaso.merciai@amarulasolutions.com, cui.jinpeng2@zte.com.cn,
        jiapeng.chong@linux.alibaba.com, steve@sk2.org,
        ckeepax@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: codecs: max98088: remove redundant ret variable
Date:   Mon, 29 Aug 2022 09:13:19 +0000
Message-Id: <20220829091319.266068-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value from devm_snd_soc_register_component() directly
instead of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 sound/soc/codecs/max98088.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index b208fb530a8b..405ec16be2b6 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1749,7 +1749,6 @@ MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
 static int max98088_i2c_probe(struct i2c_client *i2c)
 {
 	struct max98088_priv *max98088;
-	int ret;
 	const struct i2c_device_id *id;
 
 	max98088 = devm_kzalloc(&i2c->dev, sizeof(struct max98088_priv),
@@ -1772,9 +1771,8 @@ static int max98088_i2c_probe(struct i2c_client *i2c)
 	i2c_set_clientdata(i2c, max98088);
 	max98088->pdata = i2c->dev.platform_data;
 
-	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_max98088,
+	return devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_max98088,
 					      &max98088_dai[0], 2);
-	return ret;
 }
 
 #if defined(CONFIG_OF)
-- 
2.25.1

