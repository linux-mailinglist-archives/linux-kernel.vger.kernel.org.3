Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C2058DB98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbiHIQGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbiHIQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:05:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED73111B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:05:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z6so10177336lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=RZq7zJW68AsB2c8MQdTOdMV2RE0j/waEnaPxwlHywbM=;
        b=b1enif4S49S0L6pRS363TzsYpTzPlU3mw4M9VK7YHx3qjYU3YJ74rVcrsKgWisbLTp
         EIjYAMf/4P+D+OFDjNA9i3ZQ56UBAtlI2w/FqN9TwpQNa6RdZa/DgdAdac6otI5N21bI
         rD5YYu0kkSRrouGuETXpRqNdKYaQCi6XU6rmQFKhP35g+41v0dsox0qOIzuDhkvZiJJQ
         tWA8F7mPdLE039DOvuw864CQmGCUzMIr3AHwg/+JiV/idPVrYAPrRLokKmuz3RiumlPI
         mX9y61zUS+B7i1njINMpRYZXVuSSEAVSBh9uum1VB9Q9GhGYFedRdljLT5ukwdvtnye8
         ex2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=RZq7zJW68AsB2c8MQdTOdMV2RE0j/waEnaPxwlHywbM=;
        b=5DXmiKI6YMdclxwuEQnIfl+tLQ+KyRN5Pag78q/lkiYKeEYkR5sRqGPd368gAT2lnT
         yWX6wFkCEr0Pk0zpmlcQY2vYdvx20bemd9PBx6paD9c7CC+EnqnNOjOfDF8cya0ZChs8
         eSZBWZk4uo20vrn1uBsulcRN+jIlpI0all6/eb5lNKbQbmMAoHJS6TJZ2wRIFaymIMER
         h1Lnw9inIyY8fDc8sKBGEOa7UXiq0MS7YaHRG6wHX0akjHS15DhXM+SUu97inM9UWWGV
         SAG/9UXDD306P7EA/uGPW+LK1PJ09NM0Pt1rQ+lvq3V7/phw6D22gpIeeIGQiThwpZlu
         1xgw==
X-Gm-Message-State: ACgBeo0INU9ll9KdvCQlx28eLr+Hiy+XTOyPTKe/g8kr8tORjXWt2nNy
        8IZfllPLpdU/QQRJRBHvO2pT2WCOdHhZI5eGSHeSXsXFxfk=
X-Google-Smtp-Source: AA6agR565ylcWliIOPSvJajMOrdjTG601AocQEVEyAYCZlBvJ9+21MZrSKDzScw7m1lluc0iIyapBW0dFsBHtKS+55Q=
X-Received: by 2002:a05:6512:1592:b0:48b:20e7:3c97 with SMTP id
 bp18-20020a056512159200b0048b20e73c97mr8991777lfb.213.1660061139059; Tue, 09
 Aug 2022 09:05:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:280b:0:0:0:0 with HTTP; Tue, 9 Aug 2022 09:05:38
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <benoitdekoffi@gmail.com>
Date:   Tue, 9 Aug 2022 10:05:38 -0600
Message-ID: <CAK4Xzm8-FAiyWU2RYFgr8dSsrrPkiwdtea7TJyjVXS01WArXoA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
Please did you receive my previous message? write me back
