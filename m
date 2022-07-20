Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3757AFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiGTD7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiGTD7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:59:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E696D9DF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:59:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f11so13836137plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=WaINJq3vz0ocNuQ+Ou0lzXoL3BgAS+qtVXrWP/E7OgxHnkbkVPDZeuR9vJIBTM4D9V
         y/jEniHIguVuecSMw371lyxaVoIFlOiRZjH5iY4jiiPoSCJQpYn/Gr1Q3Bew55OnAKjy
         C+wkzg3dZEiWT8HXHtsW970XqoTZBlabII9jljgZFtn8SlTtmItqhUXq/ROnE7K+Aw6G
         9m4Xd8wSLlpuBVovIGCf0RYYwliKzhc9mAsnSfOSSPZVGESlSVyszt3RHG4spzL61Wrg
         iL7xzZpHE3T2fefVgQ0hBG+DO48uAxyQ/MPx/rBLLTPYdIdG/cM8Di3EBZRgr4pf2AgW
         RCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=Z3rm596+fRfWxJ5ok+PdV/lREcWD8SqnYwTfKAWNLq38//Q4jI3P57YArJmOKLuxjo
         lTVrAvVvZ+JzswjQTLBvcMSia8tFIBvOtuH6lN3xVyXKQ9Ax5ApqsDxnelOd03E1bBt6
         ts5/wFgvStke9/B7jw4KFY+QUDQO3m3O83YI1Q/BXgldA+WuXGHhTvpCI2rbJ6Ty0a/Z
         QgDjkUeQa14rmQi2n0m6m3F0TWY2MsqVmOB87qP57unEArQlXM63TBw6KYBdIqMJCMD8
         d+zXhXYmbUc0NjZw7LS2C09kadANXfNPayVsgTcvarGZW7k1UccWNe8+N39ZkvkPBf7E
         U13Q==
X-Gm-Message-State: AJIora+/0Cjvjg9EWw0yhFKCMrVYCn3sfdamsyNpL/lW4e3HqhZDSalt
        7mVGkgxd9QLQNbULmMVzmTYnvw3QLVMEpgUrrbutNs+7FxACxQ==
X-Google-Smtp-Source: AGRyM1u35HNiGzstipzXQ2YnbyrBVljMO5Wk+9+XPjsX4dwKU4CP48IhqCd9v07uFqZinOkNiyyAIJcZUNFq3MiJsNY=
X-Received: by 2002:a17:902:ab16:b0:16d:aa5:9fd with SMTP id
 ik22-20020a170902ab1600b0016d0aa509fdmr6849174plb.164.1658289548029; Tue, 19
 Jul 2022 20:59:08 -0700 (PDT)
MIME-Version: 1.0
From:   sanpe qf <sanpeqf@gmail.com>
Date:   Wed, 20 Jul 2022 11:58:56 +0800
Message-ID: <CADi8-=qJ-wxZ==LJnEZ1UwacGMesWRKipSLtWACupTc91exKjw@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subscribe linux-kernel
