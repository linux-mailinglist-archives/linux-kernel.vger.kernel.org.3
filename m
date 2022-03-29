Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BB4EB2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiC2Rtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiC2Rtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:49:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E819F6E4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:47:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so18290978plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vesoftinfo.com; s=google;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=RHsR56WCcRTSomH7cO9DvvwrgGrQTVTZcFsqWeoDy38=;
        b=Q+8ANRiGHpkBuJLnVKDGjRRxoNVn5Uy/BwqpV67IR+K+QXvZI6rRrkK09FdLdjh3CG
         mICSr7KtD8BPJgMu0jD3IkMRzy2w076Z5iCip5yN+uIZ3JOVoegMIqWhsX1N7WrEX3D6
         4F1FTbwBmzqDGCx+S07hsULxWLhH7tfTltveHGpBb8UzFvxjtkbP93maF5F2fBSyALVi
         IwEplNbtOo5jjSGpQhy6SAlOLtHEwfyQZV5tuhAOGMYCafbI1HVdmubXcyDhicJxCWFn
         WNSoQkzgCFTjy9gRntysZ/+fLdKm2SePH8LwiqR8LeCmYf/dWAvyB/hrMGErDDn4GZtE
         Tkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=RHsR56WCcRTSomH7cO9DvvwrgGrQTVTZcFsqWeoDy38=;
        b=EPjvWmK1wc5rsFGgkpVpQB9l4yWW2QNHgVff64awavXVS4xDVQFXQ8i0mDXSPHCUu7
         u/wCfZn6XyzDGC7chsdRoyiVs3SXxKp1XO5SaM6B2DAx4u3Vqb6ydEi/NrmCy/T7bVzv
         Ut6IWQkFSsRIGEIlchjtLCu1Qf+2LSBjqtB41pSYIBAFF7833xIv5E0gHN6j5oWf9Kf9
         fy3O2croeZeEBdLL1HgC4CegNtpt7z4JZhjrlzWuOlmaOtO00jqSyga1jUD+7NieRBw9
         Vra7+WGiPF1MDVJZSO3wUql5iwkbHSSga6Z5sFkBDBf8T1vefVGl6hVt29xV6zj2KvK2
         BAiQ==
X-Gm-Message-State: AOAM530nsocrhv3tXq55XePdRzgQOsHqNBG+2nK8VDMghokqSVjCbCU7
        kRDUw5/VwtYgenJ6OtIPTS9nNft9Pl1oHA==
X-Google-Smtp-Source: ABdhPJx/V6gCvMqk6B9YjU8NKzLlL07eqS36XUyFzI26GNwAAuOnRkFlXW1+yO/tnxUZwJOQOWjB7A==
X-Received: by 2002:a17:902:7ec1:b0:156:17a4:a2f8 with SMTP id p1-20020a1709027ec100b0015617a4a2f8mr9237806plb.155.1648576069220;
        Tue, 29 Mar 2022 10:47:49 -0700 (PDT)
Received: from ?IPv6:2405:201:d001:4dc4:7937:3c53:a94:a69f? ([2405:201:d001:4dc4:7937:3c53:a94:a69f])
        by smtp.gmail.com with ESMTPSA id nv11-20020a17090b1b4b00b001c71b0bf18bsm3759766pjb.11.2022.03.29.10.47.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Mar 2022 10:47:48 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Jessica Pontius <jessicap@vesoftinfo.com>
Message-ID: <7921d9d4-a7ec-6d2f-4604-fb3698e91465@vesoftinfo.com>
Date:   Tue, 29 Mar 2022 13:01:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Would you be interested in acquiring an email list of "Wine Lovers List" from USA?

We also have data for Beer Enthusiasts List, Liquor Enthusiasts List, Beverage Enthusiasts List and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Wine Lovers List.

Best Regards,
Jessica Pontius
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject "Remove".

