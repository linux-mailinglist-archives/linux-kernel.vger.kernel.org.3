Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F527577E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiGRJRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:17:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED513101D4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:17:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a15so11229613pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=Kmq9dzTBTotMtQRrgxwnDTK+vS7Wfgc0PshcOpsc9qUz29TfwqPbzF4zzfO9PT34ii
         fZsiQPRNRTfYV3yu1LSP0IyJ+SMHeUMgyu0USoOtLb2BXyMoVfC4KyKdMG1HTlX1Pziu
         kbYtvoQs2VIw31c4laRX6kIZvVA3apqKt3yOFbRMaJIoZJLiy4u1pJqsSr83R2wTXnzq
         XgeRJrmbeqVy4Yyi5LHZu4g+hqDrHiMwTU5Y9IqZOP8UqLWV8VCt4zkiwkh6TPd9GDEh
         d+EA/lR+Nt9vaDIg+72zByllR0W1omBSaotQh8JBQFvKAv7FAAU99v44QJxY6rfdANez
         /LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=OwChOGJyEYp67R4Oqn8W4EcAb031svfBPFWbgk4S1ueNdrB7LIPBVmw4g4nKZWFIYo
         qHgZ9jgKJXxpF/cnDq3kl/5BnIX7y6+4Z8jUmqO/2quExs9n/VqbcLtkDugkCOvUlORl
         g1zoRZ2rHrBezvnWSnEbrgDuH62IU08iJ4cFjzsSffNQHIRdeqsYzHILx7oPN+1CBjBN
         GZZmknLdKwzZ8Mee5RIIzkegUynB5hPnJY3j25nQEGEodNoOiEsV3t6ZgqTlFXe7su7t
         G4IZbAGj741d+tBIVN2jjJRhgysLjEqV+nDeSvfo6s32tReaczi4GgzNeHDjNP+uL9ij
         3RNw==
X-Gm-Message-State: AJIora9YacyrQnUtIqcPhF1W+Sz/xRSAOCvfxOQ0lHfo5JYxXu8NFJeO
        tKyM+hZcIS7yfKVZKpPx12ZfIu/xh0ZvL4SEx90=
X-Google-Smtp-Source: AGRyM1sroTT/A6dXEfjxbw4Z6jPTusGA1/kqBBLCe38hSirB+Va1VUwKyhXa6n+uXZP+71T/hM/rhSsOdM7wYXmBVeg=
X-Received: by 2002:a17:903:1053:b0:16c:38da:97ac with SMTP id
 f19-20020a170903105300b0016c38da97acmr27168052plc.153.1658135850258; Mon, 18
 Jul 2022 02:17:30 -0700 (PDT)
MIME-Version: 1.0
Sender: chrisdicksonchris@gmail.com
Received: by 2002:a05:6a10:cea7:b0:2b8:f444:258a with HTTP; Mon, 18 Jul 2022
 02:17:29 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Mon, 18 Jul 2022 10:17:29 +0100
X-Google-Sender-Auth: -BPdBTwSktXi1sdDwS8Ni2jAhz4
Message-ID: <CAKhAfvhtoM=PYFFBNqMQXTnm8ehqLJ=km-HuRDSaVviLGXHJ+g@mail.gmail.com>
Subject: REPLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Chevron Corporation United USA.
