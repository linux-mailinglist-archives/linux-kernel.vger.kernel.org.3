Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E495810FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiGZKVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiGZKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:21:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E21057E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:21:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x91so17182948ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=jveyBG06D/n1bqoyIRbG5FLD+LD2HIlg1YZci4oKNaIBM0KQNUHuEAtMKJPMSazsvL
         xdsPzbyuA9aqdLxi0YeHrMCWJ/3COWiCFHRUrWLBXRuv7jxz93sUhDERbGy7EwppF5no
         7LCExXx5mkTtX1zlz3g/KZcEuRXOuxUXJajx5JpsdL8wclx3XQGPBBxpY5sMvKe8D+7O
         WknKauyqfApGBESWWLaPEOks6uYIXuPo0b/Q3HYC7KGbV/5XTtmi1fpvAEk+ePYenlAo
         Xytx6RfUSvTyuEGo/lNghw8hduQ9Mip4qaGEGuZxVc6P7FhDzZjUgJgnJo1PX/PB3DeW
         dZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=cx9Jc2E7ZQ00yt+akmb2x6Ui4hcO/4ZcJDmPqdoDkfJSISVPDUwxGOxF0TG/q1eaXL
         hdpW3324WLPtAP83MgMqlDZJ6yR4r+3Cr+oFSbE8Hi63ISI4g+fVFyaFEA3qwDGuyDa6
         3gI39vKshrd6x07gq9OqSP4+An/jOEknjKVYDdlX8JGzp0iVVhscVup6oD9o67Fucu+V
         xtnHDeKUNYkxmJgs20X9hHjoB346QB/Pod2Ksqg/0f/C5McQNlPsqXQP9EI59L2PaUkL
         2VooJfzEY5++DYBpX7Ok8wNK7aYAAMBtyrbXoTJRP7P9sQi3LstpGg8zBeKuSZ5U/xcK
         Ie4Q==
X-Gm-Message-State: AJIora/uCo7IaIbafqG2v0l/G+K5E3nkhrhGmgO2XogEIZcXEqAlVTM6
        By253emNwL00oez+jcKGBiAWzILwUD3Ix7R5euE=
X-Google-Smtp-Source: AGRyM1sNdgy+v4AYGpGySs6L4iejaYmUbMARQLmADcO3i+JleTkB1awAHcHlwct/NtgczAvIIhSVG0GOo9XJ05T9RP8=
X-Received: by 2002:aa7:c382:0:b0:43b:bbaa:31fb with SMTP id
 k2-20020aa7c382000000b0043bbbaa31fbmr17844782edq.269.1658830859999; Tue, 26
 Jul 2022 03:20:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: adboulayewale@gmail.com
Received: by 2002:a17:906:3485:0:0:0:0 with HTTP; Tue, 26 Jul 2022 03:20:59
 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Tue, 26 Jul 2022 10:20:59 +0000
X-Google-Sender-Auth: yT7lMkZ9vRcdCiR4sfX7OL2IPOE
Message-ID: <CAKZu-sWoYXtd9dXyXzmc15bQzsBGZ1CQX8Y2TmPhDpKP4w2ykw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5L2g5aW977yM5L2g5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
