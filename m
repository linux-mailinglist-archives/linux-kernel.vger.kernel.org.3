Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6425573E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiFWH1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFWH1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:27:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958EF4617F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:27:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso1725354pjn.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfKMzQ3n7oWhEZvxiTgZK01ntnt5IFRVvlxp5KTIt14=;
        b=CUkfKG0/NPlBnTlbqqSIL+1PMUkV1jGwM4G5Lqq83p57XUos0QMNsYQL6yxx/zx8qz
         L6NfC5UMdFzSXLLfCmrulU59rFS6w56Hrz0vzCPNbW0Qhoua5Afi8NRmb3fJXsCD2hh3
         N51RdWg6wBifRMqSFJT7+1TR524NW6aVxkME4gcQu7WrytJ5U52DJbLahC8YRPEpOxxJ
         K4u1L5As1kg8BDJvsXBQnX9QspjU8j5qwkfI1czc4u6IpFogEwjSMy68bW2Pw8uzupnp
         nDxFS4oo3og0EPqvQHXv0SJDgB6Z2RCnUNLC84P3FN324PUqY8vsJPUeUxL9cJ3W/fTq
         cDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfKMzQ3n7oWhEZvxiTgZK01ntnt5IFRVvlxp5KTIt14=;
        b=lJMF54jRW/C0wQynt7TEtqcVLYgofSPuXATgfzVpFbaMJ4Lkr3HXKCuYxF9Lg26pAM
         nhQhsiqACntEc6odfDNUpWhgNjPEWMDBB1SW+XLRYeBpjafmkQRV9KBWMEDjl8/jsOoN
         twgjwqfg+FQoxwuNESsGLJelwIHZYI6GAN7w3eNA2pn3RagV0NlaZrnT/G3XZR0O1oqK
         wkgkekTtbBrOPPKTcLAhH9cUDPMVHD5o2GwURHNljleyMxYJbIs1sjSmf+uSZEKapUND
         wkQq+tiDsiHBIfRNZB2XYtzOJCMhFuuzkGdhx/t8lQo9nmPDERFQ4lj9tXNDrMWeRJyu
         aLlQ==
X-Gm-Message-State: AJIora8BcbTUODpXuJyf1+fJ0ef3Bg5915GuesO0chqYbMrwCwxo0rIj
        ZGltT7j2mDHjnjs+6MKhHgfikg==
X-Google-Smtp-Source: AGRyM1tHROO3JneFALa+PI3JEqFfGln/vMyEnDrYVj0T93WYWVgkWaCweunmqWEWhVI3YwK+iflgOg==
X-Received: by 2002:a17:90a:64cc:b0:1ec:c7bc:d998 with SMTP id i12-20020a17090a64cc00b001ecc7bcd998mr2538544pjm.21.1655969220107;
        Thu, 23 Jun 2022 00:27:00 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902f78200b001676dac529asm14160908pln.146.2022.06.23.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 00:26:59 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:26:56 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/16] mm/huge_memory: correct comment of
 prep_transhuge_page
Message-ID: <YrQVwAxFRApWaSIh@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-16-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-16-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:26AM +0800, Miaohe Lin wrote:
> We use page->mapping and page->index, instead of page->indexlru in second
> tail page as list_head. Correct it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
