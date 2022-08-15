Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3B592C55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiHOJQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiHOJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:16:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D0E21E06
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:16:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j3so7100107ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=WKFNDFAQil/gfMzq3J7KaiiRZuTdNkHEG08Ff3jZJBQ=;
        b=PizQYHZxk43qdm/k2RZjHY7WZrfVR/PfCJxszzGJcVEksI1WoTr9awJLavFqvzgQCx
         WjP9P2zKiw3eTQ8vLKz9iM59Cst6LEM1HOdoa09L6MnG5+pn6d7O6Z+HMLRdfOLVr501
         0a3YnvNjiUuSH1SF2v1b5zgIRVgvBC3Hb62LSJ80WGsWbVoFWViWonoUv0EtfL0noEbo
         wi1IrCCiuFJ+QmORoDHWZijmoJAqO/DttbxoZaw6Jni/HTcg7OVaEW+bH/4PUwS/agke
         TnY/0ouBZShXDl90wnzMBe8o8OI2S30xQRbqROEFyiPcLYZ+4R/3pWO+F5jbG15013IY
         rsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=WKFNDFAQil/gfMzq3J7KaiiRZuTdNkHEG08Ff3jZJBQ=;
        b=oBHtaAsr2gWUzXDGI1mAqeeueGTdJaJMmIJRzIvrA7qVv/Qt0mDmvglsVLfWqs1B0C
         zDBMwjcJtFkKApKSqj/OBm9XAC1RTH9V334Bdu7e1rPmLx8SV8gOcvoDTeO+Uy6sWWCI
         Q/kDkJMzAyUq5dNwJUT7CSps9iXBahS/F5FvR5riUJGAHtXhJelEriwoLc2arkD+Ss2r
         Y+AtrshXlsZO4e3pWbg7G7xmy4EW9PgoLqfmKlV6dMgKMYyMA8dSUrSGPlMVXdJAZKb3
         CrBsdMOdxHzY55ir4QRoMNGaRRQH8jnl9jnoB+yl3iGU176nWtIi2c2yfkFR00L52GLZ
         fzmA==
X-Gm-Message-State: ACgBeo3XihC8OaKijdGZtu7BFJtG4zAbP5EdolUK94Kj87I8r0A5Dklt
        sPyTDFkKzkuZqcGTVTDa6+EOEWv3Fcft6v/Qmc8=
X-Google-Smtp-Source: AA6agR4jc2rJKtWXf05OvxgD5B6f5XMdR3x+bJd9PjgHRGHPuSn430jWq2G0N/rKMskt4xXpjPgZUeoDuy7TfKSUIEw=
X-Received: by 2002:a2e:3210:0:b0:25e:6091:d9a with SMTP id
 y16-20020a2e3210000000b0025e60910d9amr4423323ljy.343.1660555013563; Mon, 15
 Aug 2022 02:16:53 -0700 (PDT)
MIME-Version: 1.0
Sender: josemarpinheiro14@gmail.com
Received: by 2002:a05:6504:4281:b0:1da:48c7:e143 with HTTP; Mon, 15 Aug 2022
 02:16:52 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Mon, 15 Aug 2022 10:16:52 +0100
X-Google-Sender-Auth: rkYI3xUhNvL7nmn2TEUG-EcTgQc
Message-ID: <CAPJCG52TGYGOXPJdxxp8QwSnyAZn4W79wA4+VGO6LJaGFc7C4A@mail.gmail.com>
Subject: update me if interested
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

BEWARE, Real company doesn't ask for money, Chevron Oil and Gas United
States is employing now free flight ticket, if you are interested
reply with your Resume/CV.

Regards,
Mr Jack McDonald.
Chevron Corporation USA.
