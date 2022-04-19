Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49105060FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbiDSAk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbiDSAkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:40:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051B27162
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:38:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x24so2789065qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:disposition-notification-to
         :content-transfer-encoding;
        bh=lFL4HqTDYSqVDYG3taiQXJ8IaYIwL8oENCGIfaheEGw=;
        b=Nn2fzfo4bJBsygDsTEHg0RzOUeQAnO3GIs27r+IfFPydMO6zLEiiPz+H7DuhQAfWW7
         zH5xwfcEayhWl3MplVI6gD16aKiJwX9Qq/3en/v29hNwBcVASGF9Fq+4Al2SegNJsw0k
         LuR8FtbWCbxv0PVT5QG8xBTsksmQprGmCu7u3D6f8K8WnOpPsz+FIl2ljv37mJVAle1W
         WzZpcXAYqWIWfgzdxl+Vylw6cVDR2B7xL1ydvHLHO6XmqaTtPqGryjEzXqfTk7MMXzu3
         ysQP6J122RjvbPZvPLY4HXN8lJwgFxGyL4ao2bJq8AGR+Hcss8hn2du8iSDg1iEwwEsO
         U4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:disposition-notification-to
         :content-transfer-encoding;
        bh=lFL4HqTDYSqVDYG3taiQXJ8IaYIwL8oENCGIfaheEGw=;
        b=Cj4lbORtCHN0SJ1WqEbxbv7Df6C/ofiQzdMeV9LmJpTnHGuzpdphhwcMK0Wlcz0XPf
         4PZJHMCcZyflMT/KbBdVjweKAaH4vcC3RVg5zzJfRqTV+Q2YhsFxsC+iqVliOxuk66Dn
         dCSOXjLnGvDHMNeEBmLW5+4JpTQ4eRbRVrLEuc2lCQz8wBACTcIdkXYbUOjumbK52r07
         wzFMIH84B/ZpUFDxYCIY1asvguwIt12xUXLVaFNFLStmk9rOdUKJdF1FdQ6EGEoPsMeD
         dBizKU5stgEOPGtHWTYreE50iLdjqQ7H5pUnMr8uNtbUwBISkNY3lElXoFuYcAtEyUl7
         UN0A==
X-Gm-Message-State: AOAM533ulviQrBzuKYm9btK3XhGvYsEUagDbiKIMfzGQu5bL5StOcd6r
        Q2MKUUZFvDQOxGJTS6ADfi9GjTQ1e0E=
X-Google-Smtp-Source: ABdhPJwurX/O3cGN+tb+0dbTcNaHgguJyUPvrq3JQCXQaDShnp/qgOFqP98ikwlZrzU82ILx93iMpg==
X-Received: by 2002:a05:622a:1210:b0:2f2:2620:8562 with SMTP id y16-20020a05622a121000b002f226208562mr2412924qtx.118.1650328692012;
        Mon, 18 Apr 2022 17:38:12 -0700 (PDT)
Received: from [10.1.1.117] (pool-71-121-149-202.bltmmd.fios.verizon.net. [71.121.149.202])
        by smtp.gmail.com with ESMTPSA id c79-20020ae9ed52000000b0069e9bfecd6esm2410895qkg.98.2022.04.18.17.38.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:38:11 -0700 (PDT)
Message-ID: <e59bebc7-ecfb-cd43-4914-a772acc35ca7@gmail.com>
Date:   Mon, 18 Apr 2022 20:37:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101
 Thunderbird/100.0
From:   hanasaki-gmail <hanasaki@gmail.com>
Subject: Kernel audio : Realtek ALC1220-VB : support
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel audio : Realtek ALC1220-VB  : support

Looking at the below motherboard.
what .config option and kernel module supports
this ethernet sound chip?

What is the first kernel version having support?

ref:
X570SI AORUS PRO AX (rev. 1.1)
https://www.gigabyte.com/us/Motherboard/X570SI-AORUS-PRO-AX-rev-11
