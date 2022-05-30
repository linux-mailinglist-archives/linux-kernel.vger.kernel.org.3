Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C9537500
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiE3G1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiE3G1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:27:32 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5801A12626
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:27:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3043b3f7d8fso89126567b3.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=33H7bzlF73boyoKARvolMJlGymprQ+hHPrvlaQBxLsY=;
        b=KI2uyq8bN8xIOBPbi8Eoh2LawlzcOsZc7uTQJ4dglCBkakZSnjz4hW8HJ5+akLGc3v
         xLOd8Pys5KW9ZhHYPb20ht+MnZpyeUjxEy3b437mfN7OjOCQbgiBoZ1jFk1LI9c/zYV3
         V1W9KaUUgQ3+5RWiPMO03PoZlE/RsV6EB3WFvfrsgipnDRmTDl6yot4epGrGrw1pvPwB
         cyccXfAmZPXuNz/PJ+U8vzkm3ICtx7bH3LQOHODQwY498WnfiRTv1NFWVixY/knapbxe
         3d+OGSlfSZL6EQVmY+e8pMvl8VSWjkiJaKmZq6Z9GOreyuf6TIxcJ7KpSaZHEcNUaxbv
         2Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=33H7bzlF73boyoKARvolMJlGymprQ+hHPrvlaQBxLsY=;
        b=IUszFvND9z0DiBu1yQJh8Gg33J2FaPWZmiD7JHVnyk9VYRoohq3R4ZB1oMPA1h/gBR
         ZyL+nhe4S1S06tdmDO0k3rKc1IQrS6FKyTXJ4aFCwVjHdHRv2DuZCFuj1oQ4sesbNTfe
         LT1BPzLza/1Uo/ksgLtklBEBd9S7hshJRzf0FS3/w07RbJHl7vbnWEHDIVg86I51nsNV
         VOuK/sr4100zDaBhGpwh7SyzGPLTPy0gDomE1NXv1LnMb0Gsa+1ShGpl7/MgkybcKdDX
         cxyFI/wEI7EmKdo/RF6qyajV4V38aFy1QJi874RY3YAtl8xqT2GcsOo8SEDN7G46y1F0
         Kixw==
X-Gm-Message-State: AOAM533Q/NK3WUeVNq529hP7Vta6ME45NNrVpyXG442EBq0MoRA2gOOc
        0KQuerdw53mFC1C7jx+qjwv5hbYAJ/GibP8V468=
X-Google-Smtp-Source: ABdhPJzUb5is/oA82BjpfhKTzB88mmwRGO5+ktoTVZW6XNsU/AUQKDvptUSRJfrKVNVsJ3zxSU0KGfjLgloXplMIcP0=
X-Received: by 2002:a81:2f8e:0:b0:2fb:9986:7d12 with SMTP id
 v136-20020a812f8e000000b002fb99867d12mr54017076ywv.420.1653892049739; Sun, 29
 May 2022 23:27:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:218c:0:0:0:0 with HTTP; Sun, 29 May 2022 23:27:29
 -0700 (PDT)
Reply-To: Bakermarrtin@gmail.com
From:   Martin Baker <williamthomas7750@gmail.com>
Date:   Mon, 30 May 2022 06:27:29 +0000
Message-ID: <CADGh47KBuzn7TZG96cFOxiiHHwSizX_cnW_dnG1y8w98gUYZdg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I wrote to you this morning because I have something to tell you, please
let me know if you read my previous post today.
