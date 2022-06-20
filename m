Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD98D552424
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245560AbiFTSkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbiFTSkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:40:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA41FA71
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:40:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d19so12849013lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=LY3wR+woW8P5Zqd1/UrCTP+p/ZV+/ddNZWD8k3q15qs=;
        b=mQPDmMxSTCqHY3EFcL184zIl0qhPza4CR21jHa2Ci+wlbHhx8xUdWoqC85MFrpuLG3
         ixkcTqs9qaNtE1k1PJEyBSE5RDKYjMVBwvzu5RioTgx6Tpqo4H0ShwuBw4jLxAthsdbM
         hvLVXe723UhDUZkk+SgRbS/3XG3evLGMRjMOLBZNIqbIIwTXDVXXgsZMC8T19HO+C+tG
         FYfcAnjnrj/EH5ZZOAf6LY26yibwtGHaz4G86RfDgICsb5zS9OLgI6POvT/h1lLWIRdU
         dOz72qoGeeZI4lvKS7F+CfHY8te/pDh0gcx46AQaZ97nYwWUIv2gvuAIi72ZXxY8SHYo
         vSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=LY3wR+woW8P5Zqd1/UrCTP+p/ZV+/ddNZWD8k3q15qs=;
        b=bZ+LvfTsO8SiR0ybWxfaAjCbEtFdYv8T2sL8pWRm3w9a8cDdU4JU2eHVm3g0SxJqiM
         88U6L/4aU+r6RGaH2kbjLb6BqbeCrDtilEy2yqTkhnXTiqrLj7dB8WrbnxlH7ZXOu8Ta
         brx9dVXzFXpkXt3lVKHHFLNTbNyESQSNqznNOCshRB0DhENgnMJZ0bgpEYf2AGRrF04f
         K43RcGUH+a+CRggwmR6n7dr+z33HJ/LeW9D1akNsp9n5AvgpIlxNUapXTd7S8VK9qJBR
         AIrZuCH5IIk6BYR2mPXH4Tjp8L1ePrgg4jEbG27UadTNix0ow4W3zdTiNN0kdRgyBapW
         rnAg==
X-Gm-Message-State: AJIora84RKfMw7H1ceraxKLNdeUS6hzBVJqZONsnRWlHTwz9QnS9N3hJ
        TOIK5FMmbWfA6K5F+Lxi7mPsCgg2+3S1oZYfhQw=
X-Google-Smtp-Source: AGRyM1uR+y0Lzj39+K90ZVVE1d4sVKQQtkhwRO9u5/Xaftm90oyA0onFMqxRsjYfeVnOBnD/DtivaTO8TGfbHnQ2glE=
X-Received: by 2002:a2e:8349:0:b0:254:224a:3c8 with SMTP id
 l9-20020a2e8349000000b00254224a03c8mr12495983ljh.406.1655750436891; Mon, 20
 Jun 2022 11:40:36 -0700 (PDT)
MIME-Version: 1.0
Sender: hannajustin101@gmail.com
Received: by 2002:a05:6512:b8b:0:0:0:0 with HTTP; Mon, 20 Jun 2022 11:40:36
 -0700 (PDT)
From:   Mira Thompson <mirathompson1010@gmail.com>
Date:   Mon, 20 Jun 2022 18:40:36 +0000
X-Google-Sender-Auth: BU18GOH9IIkC5PefeOO46Yq7C1c
Message-ID: <CAGNcapMk9NPVGHBCLqjXq3aAV1kB489BqQD=tbL2kDxqbQa=rw@mail.gmail.com>
Subject: Hello
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

Hello sir,
Please i want to know if you receive the previous message i sent to
you, please reply to me if you get my message, thanks.
