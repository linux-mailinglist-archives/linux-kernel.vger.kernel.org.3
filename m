Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD658C1AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiHHCfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiHHCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:35:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61094E97
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:35:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so7875510pjl.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:from:to:cc;
        bh=YVyLLvwQGdhapgIoA+Eca594bJs0oU8fzFb3turAlJs=;
        b=FjeIgoQwYYz8soy4hb/Pvuu6IC1FAvAmrTdvkZcHPR6dbG5Wieg08dq+ax/Kag+Eu1
         4C+RDxJ50ttxWd2qJ/tO0jNjH2Bvi3LLGDSDQ8RQdmTX230CrObXmpr6VHJQQg8RO+fE
         8iVCPd6whLyuuJNEvdFdE3+xz1q51XMT+0OMnL/S9iL9tE1eR+M/t6VcGSKkopMDd2d5
         UGonaJ6YqtBMi4qhUB0lcSMiieYpv8Xnh07bIvLP9AhAJqx5Jrpj5noIVSG0FzBnPBqA
         1i2xlOlktNsJqgmCypTYkuBaCKSVKHicK/Ej3lgr5l/wJxKmQ5MWI0TfSikUF6Q0uWJL
         2GFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc;
        bh=YVyLLvwQGdhapgIoA+Eca594bJs0oU8fzFb3turAlJs=;
        b=zvow78D+WjEALPlyAuZL6vsy0gx16MVn0ZRpFZod1YFDfeAXMB6Mw9DI3ZlaTMh2+I
         6Do5DKcw+aM9c0tyUpi6Lgz4lsMCO2I0BOvq50M98EqrJXctAzB6eDt99Hu971/bVph8
         oLU2OfyY64CRK08M4yG7gugg1I3yOITh6vVeWJa1YJIxOiVvylLj6RthCudnx8aoyhDR
         tb3Ju4BChrkI+mRxtvc1dlXzmO8BZuBUinhgmPX9TebJ3mXb62SwcZUMEh5DL/AW+pYt
         qptHh9YgYnYhGVBxD6oLu3gbCUl0bkd6YqmVNPYWQy1D5pSJNoPw9GZid4npzOdtYqZN
         6E0A==
X-Gm-Message-State: ACgBeo2PDAoSj5qujeO0uja8235yAiD6M5Kj+q2U0pd7thfqfJcDYelp
        WGmkmIOBBtT/zOu/dd3KqIPd6hI8XGjJ95dU
X-Google-Smtp-Source: AA6agR5sWn3v2VJIOv+7NJm6WaXZoDCNdZ2oUeCLT8vRUBa8N+W9rJ1ZtPXLAj1ny19FgU/p9rBNHg==
X-Received: by 2002:a17:90a:b00b:b0:1f1:6023:dacd with SMTP id x11-20020a17090ab00b00b001f16023dacdmr26465699pjq.184.1659926121581;
        Sun, 07 Aug 2022 19:35:21 -0700 (PDT)
Received: from [10.211.55.4] ([143.92.127.224])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090ac50600b001f3126b104fsm6975046pjt.31.2022.08.07.19.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 19:35:21 -0700 (PDT)
Message-ID: <61ecca29-2d01-af2d-3d18-62dad41c63b4@gmail.com>
Date:   Mon, 8 Aug 2022 10:35:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
To:     linux-kernel@vger.kernel.org
From:   "brookxu.cn@gmail.com" <brookxu.cn@gmail.com>
Subject: Choose 5.10 LTS or 5.15 LTS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to choose an LTS kernel version to use for a few years. As we 
know, the 5.10 LTS has a 6 years maintenance period with the help of 
huawei. But the 5.15 LTS currently only has a two-year maintenance 
period, and it may reach EOL next year. It is currently unclear whether 
it will be extended. Coupled with the arrival of the 6.0 kernel, I am a 
little worried that the maintenance of 5.15 will be reduced. Does anyone 
have good suggestions, thank you.

