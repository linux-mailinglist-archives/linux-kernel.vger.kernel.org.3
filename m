Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82028550B55
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiFSPCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiFSPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:02:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24DEDF6A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:02:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so412634wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XfBaW94tYLh6Gfk7V3oY1xEpClLq+agTEi5dSO4kTWE=;
        b=UWATDmDxyWlSoFCcO29rDiTh75DNIcOBzGC9NtUXB/Es3NJh00JfDHcIpk3pXiH46g
         I1NV1V42c+ep2wvTRXqy7ZK0gVzgbetJVED02KJj5ldl1515Jb4laosn8//hc7btMSbJ
         Scn51KfkPO0tt/PXKWPhLM1pcOqKYzb7r+aDBl3PJmIo55xwfuNSve2SGO/m8DVMaxi4
         apgQccBgkm3xj2jL9mP3JlsfBFAd8Id+qHk8zwSuNS0+qWmldoza8vWcPafBZ2WIE3v0
         SjpaKnpVRkBNUWtEo4iMP2Ypbo7HfkH5VXxsm5sbxK6GNm3Itzr3q994RQtHClSTrsOY
         qqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=XfBaW94tYLh6Gfk7V3oY1xEpClLq+agTEi5dSO4kTWE=;
        b=5arTV7viiaWtYiyfVP0WPB5EzMvAWxywb7AmCPESyb1/Ay6CSqPwhBiTNgZ+7nYwy6
         zS8kN6AkW3jiTVG2+OPJcKnj5vdoA/WYiohkrMoWFpLgq2nhj9iQq0DU4TOsTZSAZEbW
         kEzxdjdF5QdxXn5hhx1zYZf2XOlDVSnabsdppAU2VOwNjXxuXzi8wc2zDmLdDFiy9rXv
         VNrKOLxacn466bgKULO4Qg6+3a1hDQewEQ4p4ecthuE8BvOJlE+7b++9nUoAu4Ai8Dm/
         IaEn7nl69Vgf9FrdBCAsMkIsQ54fq7d82CKBVl7z8lW/XYnZfzDMc5ZdEZuAd3Xwv0QC
         HaGQ==
X-Gm-Message-State: AJIora/Ve6B/wnZRq1Tvprj3XI/6Qlsh13yObJtPC1A62vqn4wBuV1vR
        SP0M08WMg5maiDvECAXy/pKKy9mXWCba+bejGg4=
X-Google-Smtp-Source: AGRyM1uCKO4E6U1HyZibZZf/UunedaqaMDDxnXxwxcBNMU46kOOZPWPrLmMyMJFqyiv8cLHxMcO/+ybJnLovbzkTM0E=
X-Received: by 2002:a05:600c:1d9b:b0:39c:7e00:6b7c with SMTP id
 p27-20020a05600c1d9b00b0039c7e006b7cmr20135769wms.50.1655650943515; Sun, 19
 Jun 2022 08:02:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5c0a:0:0:0:0:0 with HTTP; Sun, 19 Jun 2022 08:02:22
 -0700 (PDT)
Reply-To: wwwheadofficet@gmail.com
From:   "wwwheadofficet@gmail.com" <moneygrambanktransf@gmail.com>
Date:   Sun, 19 Jun 2022 15:02:22 +0000
Message-ID: <CAEDS9iwPiZRpkJxYGMx6skU9n7o2dO+Dsw0pf4tRU12rFWYpqA@mail.gmail.com>
Subject: W
To:     moneygrambanktransf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NAME_EMAIL_DIFF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrQv9GA0LjQstC10YINCg0K0JzRiyDRhdC+0YLQtdC70Lgg0LHRiyDRgdC+0L7QsdGJ0LjR
gtGMINCy0LDQvCwg0YfRgtC+INC80Ysg0L/QvtC70YPRh9C40LvQuCDQstCw0Ygg0YTQvtC90LQg
0L7RgiDQnNCS0KQg0LTQu9GPDQrQsdC10LfQvtC/0LDRgdC90L7Qs9C+INC/0LXRgNC10LLQvtC0
0LAg0LLQsNC8LCDQv9C+0YLQvtC80YMg0YfRgtC+INCy0LDRiCDQsNC00YDQtdGBINGN0LvQtdC6
0YLRgNC+0L3QvdC+0Lkg0L/QvtGH0YLRiyDQsdGL0LsNCtC+0LHQvdCw0YDRg9C20LXQvSDQsiDR
gdC/0LjRgdC60LUg0LbQtdGA0YLQsiDQvNC+0YjQtdC90L3QuNGH0LXRgdGC0LLQsC4g0J/QvtC2
0LDQu9GD0LnRgdGC0LAsINC+0YLQstC10YLRjNGC0LUg0LTQu9GPDQrQv9C+0LvRg9GH0LXQvdC4
0Y8g0LHQvtC70LXQtSDQv9C+0LTRgNC+0LHQvdC+0Lkg0LjQvdGE0L7RgNC80LDRhtC40LguDQoN
CtChINC90LXRgtC10YDQv9C10L3QuNC10Lwg0LbQtNC10Lwg0LLQtdGB0YLQtdC5INC+0YIg0LLQ
sNGBINCyINCx0LvQuNC20LDQudGI0LXQtSDQstGA0LXQvNGPDQoNCtChINC70Y7QsdC+0LLRjNGO
Lg0K0KLQvtC90Lgg0JDQu9GM0LHQtdGA0YINCtC00LjRgNC10LrRgtC+0YAg0L7RhNC40YHQsA0K
V2hhdHNBcHAsICsyMjg5MTQ0MTg1Ng0K
