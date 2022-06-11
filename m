Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94B547449
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiFKLjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiFKLjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 07:39:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A46540;
        Sat, 11 Jun 2022 04:39:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k19so1591911wrd.8;
        Sat, 11 Jun 2022 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k5JtF42+YJE6bDplffBBRfUw/EAD8Y5R1ywzR8NXWqo=;
        b=Lv51i48ypEOPHuGj5ay/qYIjpqAGyoVmy2FzmJKm0xPfPdIIKiYvjeh+rtS/QX1w8x
         BZAhzpRNS31bbiYL6UfUkos2bM4X0bV2z07M8791VJmm3ggU5sNugMv2ZZG9tIWDghz+
         RInmsbNCfJY9XDf/zH3eenVNIA6f/nZaOvM+kTSxSaDwXQzs6JibZJVzclDDmhMCqVbU
         hh+60bBun70MiLSkZjiPAuDLFyrb6f4udPXziqouun6/eoZ4Qi1uCCJ6IW2qRxqdvO0a
         WQKN3Q0CiyaR64nhMC2GnUjfU3uqOTOfsBCqZ+One4B/j1ss/ZTZtn7Nf8YJNlGY3cPc
         OiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k5JtF42+YJE6bDplffBBRfUw/EAD8Y5R1ywzR8NXWqo=;
        b=IKjIQf5Y6UITzVF9efNIeGSZTgsziNBBLoGUgwIq9CoIt61JpWa6bf5EgxRAOUqMt0
         fLZZLm6g6zOeuu57Afkg09JlXN5skcG7lnv6W1kZ1RaKqG4e/N7RNWJFKb2Q81ipATUL
         pzDKrhhp0pbjGCP4y9WiXRdXO0xXJumJoF19mDKxSe2T76oJ/ye++YCOisETYwhp6ypX
         D6UggzsobnhX6dL10q+HBYgWYcbe1ZFx5egbp6gQF9fGyErvNVEakBEy52QuKzljTB4z
         hpoOtny7YS4Qbzj9GVkuNExX7xGGiA58UdXhn0fO59o05IVk1XDIH9hJjXjntvsO+k7P
         //+A==
X-Gm-Message-State: AOAM530i5t6hoipQ2sXZ/7wddYkmcaVrrHpxFIKak+jzr9HUdRXSNlW4
        B+Td4XB6YfnX9P5aLd7FybY=
X-Google-Smtp-Source: ABdhPJy7j09VnXMoeJQD98v7qK7c3VuM4941gdRKzcCrW+AJG5jhjDAhDhs+N6U8rJSDfG15zFnSBw==
X-Received: by 2002:a5d:6786:0:b0:215:3cb5:b16c with SMTP id v6-20020a5d6786000000b002153cb5b16cmr41029395wru.6.1654947559656;
        Sat, 11 Jun 2022 04:39:19 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b0039c4945c753sm6574198wmq.39.2022.06.11.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 04:39:19 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 0/4] Add support for XP-PEN Deco L
Date:   Sat, 11 Jun 2022 13:39:10 +0200
Message-Id: <20220611113914.355577-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patchset adds support for the UGEE XP-PEN Deco L tablet.
This device belongs to a family of tablets that must receive a chunk of
magic data in order to be enabled (named UGEE v2 internally).

Once the device is enabled, its parameters can be discovered by parsing
a report descriptor. HUION v1 tablets have a similar report descriptor
but, in the case of UGEE v2 tablets, the number of buttons are also
discoverable [1].

The ability to discover the number of buttons is the reason for the
first 3 patches. They enable frame templates.
Because I lack the hardware to fully test this driver, I added some
KUnit tests to make sure no bugs are introduced.
I didn't see any other test in the subsystem (and I doubt I'm the first
person writing one) so please let me know if I need to move the test to
a different place.

The last patch enables the tablet.

Best wishes,
José Expósito

[1] I don't own a HUION v1 device, so I'm not sure if the information
    about the number of buttons is also present and it is not used in
    the driver for some reason.
[2] https://lore.kernel.org/linux-input/20220516112159.GA74406@elementary/T/#t

---

v1 - https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/

v2 - https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/T/

 - Add MODULE_DESCRIPTION/LICENSE/AUTHOR to hid-uclogic-rdesc-test.c
 - Remove unused variable in uclogic_params_ugee_v2_init
 - Add sparse __force anotation in the result of cpu_to_le16
 - Add DISABLE_STRUCTLEAK_PLUGIN for KUnit tests

v3 - https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2206081150060.10851@cbobk.fhfr.pm/T/

 - Improve Kconfig message
 - Add .kunitconfig. Thanks to Daniel Latypov for suggesting it in an
   unrelated patch:
   https://lore.kernel.org/dri-devel/CAGS_qxpV2SsihEdgXZ6+7N0dxLmdRANq+qE4iUZ2aNrf6vuLYg@mail.gmail.com/

v4:

 - Group all the test of the subsystem under HID_KUNIT_TEST:
   HID_UCLOGIC_KUNIT_TEST -> HID_KUNIT_TEST
 - Remove DISABLE_STRUCTLEAK_PLUGIN:
   https://lore.kernel.org/dri-devel/CAGS_qxpFO4ixW=08ZcdcD9J1kU=B3mwoBJkPW8AKu0sKs8aKfA@mail.gmail.com/

José Expósito (4):
  HID: uclogic: Make template placeholder IDs generic
  HID: uclogic: Add KUnit tests for uclogic_rdesc_template_apply()
  HID: uclogic: Allow to generate frame templates
  HID: uclogic: Add support for XP-PEN Deco L

 drivers/hid/.kunitconfig             |   5 +
 drivers/hid/Kconfig                  |  16 ++
 drivers/hid/Makefile                 |   3 +
 drivers/hid/hid-ids.h                |   1 +
 drivers/hid/hid-uclogic-core.c       |   2 +
 drivers/hid/hid-uclogic-params.c     | 201 +++++++++++++++++++++++-
 drivers/hid/hid-uclogic-rdesc-test.c | 219 +++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c      | 124 ++++++++++++++-
 drivers/hid/hid-uclogic-rdesc.h      |  24 ++-
 9 files changed, 581 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hid/.kunitconfig
 create mode 100644 drivers/hid/hid-uclogic-rdesc-test.c

-- 
2.25.1

