Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A93569D39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiGGIVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiGGIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:21:11 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC078647E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:19:44 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-101b4f9e825so24438525fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=HIwZcHigXC990KrHgn4lmSJ9L34B59wwGMw9zhX6Qcs=;
        b=STrRrSdOnnl1Cc32kDjUjLDzYPgnIYsKn/EVakhrvnvPjSqr+0e+C8kfVZvWu7QwGQ
         uftLyVlZAPpua3il9XROdDfTArzq4yr/LYCsOOvSYBiCqHjuivSMJlxeb/6vnuLO7gSi
         gsYUAHo3SbrjCIh3+z9z1V2jU6aqkTcisBeNvS7VXrPdegObBsUr3NHU/B/3BtXCAqaK
         U+0GZfrxbA0YFCbw1/hn0stqrflz9pwpbeZxGoctXqQcC+jWMNT+FmpI3Fupl4khIY4x
         EdUWKX/Ut75I7ukZWFlXbtDIzkqWlP0y5wZRUAAKDJ2ewktC9XhpfDZIb/SY8I6+ofLs
         7oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=HIwZcHigXC990KrHgn4lmSJ9L34B59wwGMw9zhX6Qcs=;
        b=sdedJMFoJoHkZOJOAjv1fDJOR9wbERTuY2Hhw6UfXLfmCEimFecAWwUr6M/XnDcC36
         S6SdAfvTd5Qe0NImsoFjaw0Ukz/cDc6nQlEzxMECCdtc9wL72AH4U/8LxvfjDNFBL2Ns
         Fvfy+CQoGU847oozawtDK2Hf3dgXnFvD9LkvVdq85KPGIxJXjp1wqEvAgkiqmY4xuXm3
         1MI5a+OkKX4nO6gV9qHAAVMY2owJkDjMo/1vhQIEp6nSaENYHJoaCnUM7XArM5ENvQc4
         wzYiNqlI83R8sn8QTb0pa4lg6F2iXNPRc9In8pTa0gl9knD4+aeS7UKgsVTNDdFUAqFL
         fU8A==
X-Gm-Message-State: AJIora+wlQO8jwTT+GZQHpSFwkEGB42ou6DG3wAPzPGh6xpbXBG2AYs5
        WJfnqbn2QtaOkP3Q/zAejBxTIEgTVxFY6btgSnM=
X-Google-Smtp-Source: AGRyM1uX1QeS9J0XdNFoKfMLeIViMwVuwAHQRfzmGNosElg02orOaDf4X0pL1/0i26E16AJsx7Z2BVXZXmKUGANbmpg=
X-Received: by 2002:a05:6870:4203:b0:101:8acd:c666 with SMTP id
 u3-20020a056870420300b001018acdc666mr1957507oac.260.1657181984019; Thu, 07
 Jul 2022 01:19:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6840:f00f:b0:c59:2f1e:cb5c with HTTP; Thu, 7 Jul 2022
 01:19:43 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <infotonyw@gmail.com>
Date:   Thu, 7 Jul 2022 16:19:43 +0800
Message-ID: <CAGsB4p96sKaYsbOspncTFjoAED_8EkvvZHgpgvyYDm3Yu40+Hg@mail.gmail.com>
Subject: PARTNER
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

CAN WE PARTNER?
