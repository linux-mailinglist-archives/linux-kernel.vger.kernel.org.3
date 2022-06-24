Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D58558F37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiFXDnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFXDnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:43:42 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA2344D6;
        Thu, 23 Jun 2022 20:43:41 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 88so2921043qva.9;
        Thu, 23 Jun 2022 20:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dqHvmEuhpjWCEOs3uOFcIhTjI4+MyXr1vG2++g7unY4=;
        b=kSkfrmqiWD2k1WkWrgvgzqUWnrdvkepJYaR3hn4sXHROd48zBZEfHFld/MtSPM8Vmh
         J3yjrledBxtAlkhsjDPWE/a9av/4sfvlxyteifb2aGu4NUcXKtONSQgqFyhGVwEog3OD
         17IsC06Unxvx5gaUky5DE/co3+m3K9u+MogK+wZTOufcZl+3f1iAq8hLP+LGHJ5nmdXt
         0uEI6WhG5Nv/F1xeMZFUjRI4zZbD+sILm5DqWAvPxCTGoAT/VJ16Z7PatNu0OlM/oHRM
         PP+S48YSw1wSF/lc+qqE5ik1XF3V+vWxUvWevianqvaF0bGdAerieJpLCVtHWcaZHrQJ
         dwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dqHvmEuhpjWCEOs3uOFcIhTjI4+MyXr1vG2++g7unY4=;
        b=RWG8K5MRX1BACFImRy7NUrQbWjV+IHZXLfaGha6ciJLigCU9FNiq96COFvpMCmPzak
         IDM3nDP1IVqCjJyo2NF6Zg8a0GHXctD35WUx6VP+bJasdN15qzooAPnMP2P11PLMm4lB
         JKQBGn55Wbm52fbjOLeojm5Ap7hRzI/NQxBVECsrcVjOOsbsnQZ4W2MwWN7fQOignA/A
         HcUS9SIZYEuIWzvE/WDr2SsWivbXuRr81qXVIHgsD2BrhRF9Hxz88csUSSu1luO1uPk9
         iRPW93rx7EbFnKEs2xFtHbhSCMRpn2gv2MFxUhnE/SIL6JI3ijOd1O7y6Mz0o/dqfOlJ
         vL4A==
X-Gm-Message-State: AJIora/AmtwsASPpAPKxM/YB2FSOuVoAZRJuSiVoTSMg1R4sSa9NF2dK
        86DJScHjuCblDzJyDvpM2rc=
X-Google-Smtp-Source: AGRyM1sK8Z0Ih4IbLNqY7DFxSNZdKQQxZ0telH9Bt3wQYYi4d4HReKN3APc/onjtOoCzFx8wcsScVw==
X-Received: by 2002:ad4:5de7:0:b0:46b:c28b:bf7d with SMTP id jn7-20020ad45de7000000b0046bc28bbf7dmr34448915qvb.72.1656042220995;
        Thu, 23 Jun 2022 20:43:40 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:bdf1:2a9b:4f43:67ef])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a454300b006aef6a244a4sm1048691qkp.129.2022.06.23.20.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 20:43:34 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/2] of: populate of_root_node if not set (alternate)
Date:   Thu, 23 Jun 2022 22:43:25 -0500
Message-Id: <20220624034327.2542112-1-frowand.list@gmail.com>
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

From: Frank Rowand <frank.rowand@sony.com>

This series is a different implementation to achieve the goals of
https://lore.kernel.org/r/20220623105044.152832-1-clement.leger@bootlin.com

In order to apply overlays or create new nodes under the root node, the
kernel expects of_root to be set. On some system where a device-tree was
not provided by firmware (x86 for instance) if CONFIG_OF is enabled,
then we will end up with a null of_root. This series add support to
create this root node using a builtin dtb and remove the manual
creation of the root node done in unittests.c.

This series modifies init/main.c.  It was not clear to me whether
to add Linus to the distribution, or if the change should flow
through Rob.  (I did not add Linus.)

Frank Rowand (2):
  of: create of_root if no dtb provided
  of: unittest: treat missing of_root as error instead of fixing up

 drivers/of/Makefile    |  2 +-
 drivers/of/fdt.c       | 19 ++++++++++++++++++-
 drivers/of/unittest.c  | 16 ++++++----------
 include/linux/of_fdt.h |  2 ++
 init/main.c            |  2 ++
 5 files changed, 29 insertions(+), 12 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

