Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6082568F07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiGFQYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGFQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:24:48 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897B220FF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:24:46 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f2a4c51c45so22021899fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=q72jtloM2SDi91Cm9eEXs5cyQKoz6sZDEvLuLXFIb7EshTx2BjZIq/SU+zmAx9A6u2
         OkhFTooEMKuWDaJGNqVtXflRgwCVAswedV3ISK1CU2bborL4CI9ob3M5dqU3Ca5+pVUZ
         ZetgEmy2eRUVTFWRG9k9SY446cb+eISHQtwcXClClz5vysey5tDoCTkam6/AukY+SJtT
         JwRibs+fYhBkhcmbSOgz6ww4Ris6YBwDeU8dAKimk1ajn8CQio3I8s7EMNYK3uy0j1hU
         MHxSU4Y8OMsHSEXHXCsEmXcSivNPxtRsFmPwmlP/WovH8Hic5zGc7EwYtUZPSBgiS9lK
         xr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=HAhMCRDd9x3zQINgkJhc8NBJrL/DCkOJlAS/RA9vgxlhpZZ84LgqsJuUHJbldqLYnX
         BPzkYHfyu48JyjgRG7apX3inYzEHwiCuJ5HW9K5Gbx9CSgL+5URpzZXGeZhuMq1gSneS
         YxoFw8FXtflhBlt9rntSCHopgborv+7xw5bABshG/jdNytZZ1oVsdXudozvRCfh7iC3I
         VWq0OuF736rOws3xR23Jrbs/re0zE07koMzGgLn1CjSyeoK274zfscsHbOt58leeOknj
         FTOahBvFTrwv9gwEW31J5yscn8wUlXxu2oNnzJjxNXh+u7eYbixXX/Tdmq14wXs9AGSA
         Pm5w==
X-Gm-Message-State: AJIora/WuyfvvxQqFVdF3A5FF5A6HEnvzkjYHY3DQPwdtau8fJjFx7Qy
        2s4+Oj2QdIji62kifnX92kVumgL/uRvlLji62qM=
X-Google-Smtp-Source: AGRyM1t0VJwpTR7+JM9mLwtps1D/owIhLHrUztAjn6gHiYvVhDcAThr8A70Egycpa14+Dl//+YEHsIqVHvKFdXK4Va4=
X-Received: by 2002:a05:6870:c144:b0:eb:5ef1:7d8c with SMTP id
 g4-20020a056870c14400b000eb5ef17d8cmr26641897oad.232.1657124685590; Wed, 06
 Jul 2022 09:24:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:4545:0:0:0:0:0 with HTTP; Wed, 6 Jul 2022 09:24:45 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <avrielharry73@gmail.com>
Date:   Wed, 6 Jul 2022 16:24:45 +0000
Message-ID: <CAFSKFDauFRxLGbKGhNfJ-rCZ2ecpTN=eGmmMEwOJObKESRv7Lg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0L4g0LTRgNCw0LPQsA0K0JLQtSDQvNC+0LvQsNC8LCDQtNCw0LvQuCDR
mNCwINC00L7QsdC40LLRgtC1INC80L7RmNCw0YLQsCDQv9GA0LXRgtGF0L7QtNC90LAg0L/QvtGA
0LDQutCwLCDQstC4INCx0LvQsNCz0L7QtNCw0YDQsNC8Lg0K
