Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4457BAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiGTPmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiGTPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:42:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE86B54
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:42:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk26so26679985wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=48fj8+SEYseTJxEMnEnTvEGFV8gDAw0PWcc7VlH/EIs=;
        b=WIAro4xCvBoz1+T5ff4qm0c4IMlvuiTmimo1+2o3h/+5mrjAO09gWQB0POmjL2LzzD
         gsrDJV3cWqdC4eefAIyHo0yGou+QeFjkhcVEw21RJi8oO+55TBxSCWBUCDtLkH7M/U9Z
         nVDL8naPXXhnNe0oR6dNkcy7Ayb3uN0yfs5mnrNoxAXFjejBG7DQR+l2AVKmln5LJSSZ
         fMlY8AwhYAXsPjfNYfacN0QXD7dbpN9BZwERs2mjkWEGw3YlPr7YkKVSnprX86LyepB3
         ZsUnruNtCEI1LPKk++kv39ZIOED4GuooCoziRIHazmcaVkkT5enW8cnBgkVIuWbtrCpf
         LgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=48fj8+SEYseTJxEMnEnTvEGFV8gDAw0PWcc7VlH/EIs=;
        b=hHv45ajA4na4Yd+NRU3H3FhGUncHhkT0N04ECTsoLz66+t4yzp6Es3so1lLoNgf2cW
         BUw7snNQAzAiIgo5S1Bx5X1vaiuVxcaNhPHxVQ10Qbe0JeWQjvhy7QtDCORvNsE7MQwq
         ZQ4UmbJynv4x6HEGh1jWiFpAio+mmjzTQmhQJkHfUf74LZsBZZeFkidjjeD6lO+D2FpB
         pjm6v2TR5X4oO6mZYD7g2peLo+XWR2c119sYoUIcodorzxWlgOY0fb1q33zBKLNYGbyb
         Ej4gitrOFPvLpENOIlmxJRPLlSZkHAH+yZ3c2+DLGvlzps8BE3e1jSCodasDd0KbOVTQ
         kWNA==
X-Gm-Message-State: AJIora/wGLbdY/Tv0mEbIeJ9PEdG4cZMoBbpdbm8ineW2h78vmhu+k56
        nbn4Jf2pT+uU1mfUPK0sOr+Wpg0W2DSREeg+Dv4=
X-Google-Smtp-Source: AGRyM1tqcsBImE4iatXjXNGy03ZZWQDy8RpoPl7n8w55zYRvmArpAdWyds00+MgYVjfx17bvPhbxZWQKV7gPSyD8+Rg=
X-Received: by 2002:a05:6000:2c6:b0:21d:be55:d311 with SMTP id
 o6-20020a05600002c600b0021dbe55d311mr29543820wry.154.1658331760760; Wed, 20
 Jul 2022 08:42:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c404:0:0:0:0:0 with HTTP; Wed, 20 Jul 2022 08:42:40
 -0700 (PDT)
From:   D B <kosdav71@gmail.com>
Date:   Wed, 20 Jul 2022 15:42:40 +0000
Message-ID: <CAN6u_H_ZDfno3o1e6sPt12nG-c_hQBFZQNU1WQpo+VmQSF6ieg@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon,
Please am still waiting for your reply on the mail i sent you yesterday
Mr David
