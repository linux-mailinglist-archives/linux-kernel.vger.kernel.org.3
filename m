Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE015A7E21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiHaM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiHaM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:59:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE30B14FE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:59:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b5so18161644wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=hYMmSrBNLzSlV0HVPL3BJFaxlf+C+SjvJlDqnIsLq6U=;
        b=a0r27ziRY8QhBdp0cCA49SN+EpMFAmyNKVlsx5yV5uIT6UFzgjUvxNCy3Z2jdye4QL
         C7NAIuhrFOkgv/T+4ugpeUH+M/FlAvj7lFTGKPXm27Pfe6oRVOroJTP64IqHIM6NmPo6
         7g0/afjb1/Fwkea+wyRN4rdbIIbBcAEdKB0nMyf3LTiyDMGazRbwxryux6rqKcK85hSP
         EOXscOboJWu0Jv0ma82v6FEw0riLffBDsK3N3dyiFJiaHl+1azuI7bQ7N67m+26DlMxh
         bWP61GQtBRvnVB4TVuRHEKp6k8QwODzN+FBhgcRoD54zkkFbxV4vDIqdRD+0Nx7EjGzj
         uvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=hYMmSrBNLzSlV0HVPL3BJFaxlf+C+SjvJlDqnIsLq6U=;
        b=C6X9IyOUkNKqa+5gd89LpaQAW2vxtROgvNwZHTuAWyti4xBrE4a4SkhsTnfWxqb7Iz
         GYJAf9D5PoOt1ZXiQuMSjzZwSNS1NQMrHnUASjvYj9he6hAndLlfSuoThzt90Yx2cqhz
         U9tUMxstSMvA2eKIUqgQq5Fx9/UVjp/h34UZd2/D0X1T5qHMFDwIhEG3okONdEEe9/av
         YZ6Sit/PcgGYhYsNJhTR7gEbekSkNKXFWZhxRxDyuf+U8AWREUcfSx0NL0XEMoE2kXab
         H1AGB8UfncquqE2/UMl5Gg8qV80SFdiCuEurS4MF2E6TLqnnNl5Jk0Z1fgU6efDlvYKf
         Zn5g==
X-Gm-Message-State: ACgBeo0iDvNFDUZUh9RkAx1g/VDFKEAonf7IwFUBRxEwfNXh0WgVJNoq
        X3t/I/ZHlNtLkgStbLwgxlFKBw4k9WliPu9aRyY=
X-Google-Smtp-Source: AA6agR51EH/JRPNgYFayoq4+tpGMQftDTQ3o4EvWjvJ7VSHS82TnRNFWh2FwMbISsb6EIR8ub88P9n0S1aeTK7IinxM=
X-Received: by 2002:a5d:5887:0:b0:220:81c9:8ab7 with SMTP id
 n7-20020a5d5887000000b0022081c98ab7mr11692603wrf.702.1661950742674; Wed, 31
 Aug 2022 05:59:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1842:0:0:0:0 with HTTP; Wed, 31 Aug 2022 05:58:59
 -0700 (PDT)
Reply-To: js3522029@gmail.com
From:   Jan Smith <hdtdse875@gmail.com>
Date:   Wed, 31 Aug 2022 14:58:59 +0200
Message-ID: <CABG=Sa+7QOEOFM7ykjZb7AqP1CLzeNvhWg7cPjFHdsVULW8jTw@mail.gmail.com>
Subject: Please Read
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:444 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [js3522029[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hdtdse875[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hdtdse875[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I've viewed your profile on Linkedin regarding a proposal that has
something in common with you, kindly reply back for more details on my
private email: js3522029@gmail.com

Thanks,
Jan Smith,
js3522029@gmail.com
