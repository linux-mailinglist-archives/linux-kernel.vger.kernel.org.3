Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34450DFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiDYMX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiDYMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:23:49 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CC62716E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:20:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bz24so10125112qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=qUXK/auVrcDYzDc/pir8kuiNpWKdf1m37eJ7GrbKczM=;
        b=BIZMPo1GCdlCUYl98HeZCOo31dYdM5COiq5taoeztoRhu3OaWZNcNyOuilx+q+/nE8
         /C/redzk+1GLQVMk/xctTsZCsGrNrWPtTiXWmXWAERipSRAqs8Q/0q1aKfBG6BX61uCY
         W4jg1s+5xque4aCPtF7ZKQkHV9wvwtV1cVIg/K0J2rhz8y+tIbk1vNzuh+n31D2oegNK
         VHuAlIAJ40eTJeK46F09p6YWnYtEoLvt2RXUs24fNiX3vs8f/BjJJjExOjqkxD90fv0T
         R5kTZ5hToCJqCpGqJ64aaj+sLERIiKnjh2l0xcLA6o/5ZOvxExEbBzsPOpfYUA5Q2/o8
         29gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=qUXK/auVrcDYzDc/pir8kuiNpWKdf1m37eJ7GrbKczM=;
        b=k3OsofdNaGNr3kRIwbC6w1ddylsjpdwPpbnJYajuxMx2UTy+sLZ3/CguqTLZ1/hnGE
         rFDYwH7WDlidlVYrQ5rZJM45v6yRaDAW9sQtcG7PmaEbJC7kyY6s3JgND0feRYCACnoX
         VILDgprznPmqgQi6BecbkMULt6uGGDZAaEk20HaiZMQM8EUakG4F/uSoIIo/VlLldP3l
         uCQ+CLyxLOWV4yoW1QWN6QC7fgxAJ2Jh1ysd5TpL+/W1CWx7VtmrGR/UiI00qF0nLCxS
         1gjSGrddlufA7U60Y6Blr2JsTC+sApRTfZ9MCXg+8mtXQQWd+3f/dRmVRDwPOGrCXUxX
         E6nQ==
X-Gm-Message-State: AOAM531aHT3qtpPn6jARsj060sIAQjaXtlByko82KTHqBL6j6JjrY5LO
        CehHm+bq6dcUfzu3/rWkRYTGdnJOoOavYlwT86M=
X-Google-Smtp-Source: ABdhPJxmOTOQvI4ZVnrqA6or2KWmdCsP8DsSxq2XwHfAj9RI5eZGsRxQtMnu0dBUX8IOizbt33uzGkQ6rIqZ9KJOL0g=
X-Received: by 2002:a05:622a:1314:b0:2f3:5726:e034 with SMTP id
 v20-20020a05622a131400b002f35726e034mr11517897qtk.297.1650889244518; Mon, 25
 Apr 2022 05:20:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:5092:0:0:0:0 with HTTP; Mon, 25 Apr 2022 05:20:44
 -0700 (PDT)
Reply-To: carriganedwards26@gmail.com
From:   Carrigan Edwards <morinjack120@gmail.com>
Date:   Mon, 25 Apr 2022 05:20:44 -0700
Message-ID: <CAGDRVaHQ77m=r_2YztgwV31WaM9ebxU_TdQBEGnOare6CLcByQ@mail.gmail.com>
Subject: I have a Business Proposal for you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [morinjack120[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [carriganedwards26[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [morinjack120[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,



It's a pleasure writing you on this platform. I have a great Business
proposal and I'd like to ask if you are interested because it is
highly beneficial to both parties. I need a kind co-operation from you
in executing a lucrative deal. Kindly indicate your interest for more
details.


Carrigan E.
