Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74E657A48F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiGSRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGSRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:06:12 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A7B13F43
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:06:11 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m10so7662241qvu.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIGT3yPvX69DwERnWyavBFcR2mldyfX5zPuK+8fcqO8=;
        b=XwlIfg7gruWwC48OEGG1CWr9Z8CT8odxCLNs5yfsz5pJLMUZeshjwOdQYyPlYH9Ept
         2cDFwuk/OpgCR3whLmkzcLymvgIe0BpMME56zo2g4WuHRzTN0/B+F06lOR+RnMbpJwVd
         4/nbPwy0VIuzyjcbFNHf+wncp65H74QVUNaaHqtxlXvVVW5/u/AarMLGPFuIBSERHWb2
         PNXmPhZMpusMoA5vBUjRGDc/eQXW4JbO5TZFbLk6mPkyzKqtLFnJ3tD7j0ChVn9bPJNd
         4lyseAcBtsTuFHqQGe1JfQnnLtZ3j5MnAnQ3+zkoeo9W2DUOlNU3lQnQq4cy7d1y07Vr
         EfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIGT3yPvX69DwERnWyavBFcR2mldyfX5zPuK+8fcqO8=;
        b=G0DFcUKfi3B5p7PLy+OwJJx9MpOrT03JBgK/95bhbzPRC8ubhljGQ0n4EKQbxZjCfo
         DRDKWUcccPgljwKheSO8g/pmQqEb/vON3vXGG3gXMzorZrz/ZqvjvI8GBhySR6+0kyMj
         0xI7lB+X472NdtRD9aH1YziVqaM02a81x57NpGoAcxKXDgxad9T4bUHnaexqaB9PDOnK
         RF6Qzy5jMV+HgA2jBdJV5egsth68MyR4nbNR9xgbU1Z3pwpG1tzSuO5rikCrPwZu8M2V
         ZhQ104DGeHAcTuWJhiYP4CxRGJzzplAbs25E+XP+5dd/2Fz6FPAcDp7b/78BTK3acHzw
         4aGw==
X-Gm-Message-State: AJIora9Em1I3YkDwOwwXeGH8TdzdsMMmPLGZc66L77geUJP8TIeR2NYV
        CszrTgSQ4VQOJRhvM4GEJoVk2p502t+XehytZw8=
X-Google-Smtp-Source: AGRyM1vwQuZ2p+lZiV35/OA0pT3+b29U+PgBa9JUdUwPYI8qezRsk/+h3Bd4M9GQk4kCfTtNAtXCKQSYvDN3xNaAAHw=
X-Received: by 2002:ad4:5dc7:0:b0:473:e8d0:220d with SMTP id
 m7-20020ad45dc7000000b00473e8d0220dmr4194410qvh.128.1658250370460; Tue, 19
 Jul 2022 10:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPRrUoNtO4J8H8aLWRCGGZkwHqtOZV9Edamd2pXVB0ooA@mail.gmail.com>
 <DM5PR12MB24695F88092ADF033A2522E6F18F9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CAHbf0-GssD3jP4ZjVQeP1Bgu+uHE3OXAEWLeZJA5VdWHzqbBjQ@mail.gmail.com> <CABXGCsMvJ6JWc3yO8Lv38ZHEHzhhOZUipA4cuc5E=RPSt0WbZQ@mail.gmail.com>
In-Reply-To: <CABXGCsMvJ6JWc3yO8Lv38ZHEHzhhOZUipA4cuc5E=RPSt0WbZQ@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 19 Jul 2022 22:05:59 +0500
Message-ID: <CABXGCsOpPb9YAjTpeOzgWS+dPaQA2UKA-cT=HhVeCskod+-OAg@mail.gmail.com>
Subject: Re: Command "clinfo" causes BUG: kernel NULL pointer dereference,
 address: 0000000000000008 on driver amdgpu
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     "Chen, Guchun" <Guchun.Chen@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 4:26 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> In the kernel log there is no error so it is most likely a user space issue , but I am not
> sure about it.

But I am confused by the message in the kernel log:
[ 1962.000909] amdgpu: HIQ MQD's queue_doorbell_id0 is not 0, Queue
preemption time out
[ 1962.000912] amdgpu: Failed to evict process queues
[ 1962.000918] amdgpu: Failed to quiesce KFD
[ 1966.010395] amdgpu: HIQ MQD's queue_doorbell_id0 is not 0, Queue
preemption time out
[ 1966.010406] amdgpu: Resetting wave fronts (cpsch) on dev 00000000b40e7982


-- 
Best Regards,
Mike Gavrilov.
