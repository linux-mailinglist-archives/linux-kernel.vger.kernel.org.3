Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB9958EA85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiHJKhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHJKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:37:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A640479685
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:37:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so17266823wrf.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=oxROPtGHPOjlXcHLCeVA9nsLcPDtsGAzCDzx4HMqJndTmMEThHFRnXX9wETyBrAXrw
         oKBJV3oSsxqNaltxEcXWXn3dsJ8jNseryF9ixZ5c1rOAEXbvgec8a7HYJbz4JvwfFTtT
         XPoP8XdDy0au4v537LAs+9nIBSxXNKZIUb5JcvBz9hpn/WtzH5zJjn4VPJ39iRSZeUxT
         gQOkz6GYzcOsFwWfPu6F89XqEWqB+Uc6v1K5ixXskWPl4umdqtDfeD6OCWaFN8LDX2am
         atVxRlVIAmfDVXlvT5h2+gnSJPM8llpDAGlv7zKbYcDTLiREbpaVR3lSqg/aYhwcXtJb
         1q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=sVvMNV3wbB8iIDuBsp6lB0NN5LIAkABc/yNYeBLOXZv8DPd2P0iUtwNC6QCb1k6c2h
         J9gxLKDJ8lCqjIZKH06glmfgeQqA+N3mLewqxAIkFMOZBc7ZcItA9Qia4P8vvBgUkXeu
         wca6Bw/1QaapibaOq6bj/zLKDxs1vq9jSpCNmHKJ3xBxEPtytKiyK8WNFKP09HsjBVAv
         ePseujBklARjpBWvPI/LKg4r2M80RoSSirjMvH59E/6dsHHDV5vtT8rhigIz1Has4Fhx
         PHfFQkHjudjjtIOzKWBG3NkaPbQsgBWFhJyt0OvqPmYJUNN1XpYAcozj2ivAsaohCEIP
         E16g==
X-Gm-Message-State: ACgBeo207q5ubjpOzV9z9GyKl0QIRPxpticmh1LuI7pNYGgrv7Pqv+z9
        U5iqDVWhx4dOFPib0s+4kKzS74MNsInMMz3z+TI=
X-Google-Smtp-Source: AA6agR7wZxedw+11SHzxRd/zofCdn68LTCLFTVcxk9Wa/KO2JrwSIERQTVsMQ2hdpMkwOq2JQ9Bensyp3ldw7WuiU2U=
X-Received: by 2002:adf:ce92:0:b0:220:5ef0:876d with SMTP id
 r18-20020adfce92000000b002205ef0876dmr17072168wrn.647.1660127819243; Wed, 10
 Aug 2022 03:36:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f345:0:0:0:0:0 with HTTP; Wed, 10 Aug 2022 03:36:58
 -0700 (PDT)
From:   Ulrica mica <ulricamica64@gmail.com>
Date:   Wed, 10 Aug 2022 03:36:58 -0700
Message-ID: <CAL+hFN0FKGkNFr4DsVedYEE0E0Ka5zTvJC-2-cNe5mEbn18SjA@mail.gmail.com>
Subject: good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello dear
Can i talk to you please?
Ulrica
