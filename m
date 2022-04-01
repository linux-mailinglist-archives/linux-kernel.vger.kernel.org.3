Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F944EE5BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbiDABg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbiDABgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:36:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A889240598;
        Thu, 31 Mar 2022 18:35:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bp39so1073021qtb.6;
        Thu, 31 Mar 2022 18:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=lpUdQnkmu36v27iOFONf3ZseM2a8SDfnThG+6rfaJoI=;
        b=KO+SHp2hyO5FOzAkbcl5F+prZx3tHpnTrNwmbYGqgzCx6veGUHkwN06CqE3+mjvjmZ
         BjKqL9SfVkbD2rmXUDA0dMPrqu/HLk6cv2alOIQG7ES2fzgQf9aTeGMK9V80janvKCYe
         2mzKk6WBt6I0nBxepgOYHrqkR0VWKWRmsDM5EkwqyVXgB4XuwmC5pMTrG55NfhrzHoRq
         YjdDmM3rnVjOBSbvAO9k6qbstleYEdvQgcuBoDhsxDjmDCTHYmKugAO0sAawJgdZSzXL
         9BchmgKMZuwFk8db12o4TZ5dILX2XbnoaYvJ//yUcvYbUHq10dt+PKBviaIr5vQBYY+y
         vGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpUdQnkmu36v27iOFONf3ZseM2a8SDfnThG+6rfaJoI=;
        b=zlNZE71L+t1g0eILpIqXCKl4DFOZ5nZSnwiATL5cKYZazy4tvi6Fxy2ZCAC43PpMpb
         aAbSTO8LjD1RdU7CfV18+9WNPLLJ6Xh+jkkllPZpdVeC9zSRjwXxe4N3guaz6vzC/8Ze
         UPHXvCrszYzvn2/GTmhgUSqe4Xuy00y3CLrg+QgaFj0j6lXzb0d6nR/ub8eLOa1GizLZ
         dLV80IGPVbOoZwhL/ElHXW7RoIH1MJQqN6hJEM1q8mktvz2tOgsSHqrxiFmbeGrqXtO8
         Mu3T1KXYUV/OuKuKcrElq1ezpOJ2NGcNF2d80vSBL3CFS+zQoUMIEmtMHDiO2Eavtbew
         PSKg==
X-Gm-Message-State: AOAM533KDi6HaKjMU3WsrYwvH90++vOmZF661/XssPlBvhBE+k8qVg2u
        GvHYoOm8wujNdjfHGvuM1rM=
X-Google-Smtp-Source: ABdhPJwH15x56Wp3o6vUCv5Dfe/2WnXWXwFxed/wvSA0j34NCyHKKp9OlGqIXwZ2JCgZnBm8cvUlzQ==
X-Received: by 2002:a05:622a:c1:b0:2e1:e281:2ac0 with SMTP id p1-20020a05622a00c100b002e1e2812ac0mr6772498qtw.608.1648776904224;
        Thu, 31 Mar 2022 18:35:04 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm834459qtb.28.2022.03.31.18.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 18:35:03 -0700 (PDT)
Message-ID: <624656c7.1c69fb81.9e8ee.5657@mx.google.com>
X-Google-Original-Message-ID: <20220401013500.GA2404167@cgel.zte@gmail.com>
Date:   Fri, 1 Apr 2022 01:35:00 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
        corbet@lwn.net, yang.yang29@zte.com.cn, yang.shi@linux.alibaba.com,
        dave.hansen@linux.intel.com, saravanand@fb.com, minchan@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jhubbard@nvidia.com,
        xu xin <xu.xin16@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH v5] mm/vmstat: add events for ksm cow
References: <20220331035616.2390805-1-yang.yang29@zte.com.cn>
 <a4f42004-7c99-8c4e-259b-903254501529@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f42004-7c99-8c4e-259b-903254501529@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:44:31PM +0700, Bagas Sanjaya wrote:
> On 31/03/22 10.56, cgel.zte@gmail.com wrote:
> > +Monitoring KSM events
> > +=====================
> > +
> > +There are some counters in /proc/vmstat that may be used to monitor KSM events.
> > +KSM might help save memory, it's a tradeoff by may suffering delay on KSM COW
> > +or on swapping in copy. Those events could help users evaluate whether or how
> > +to use KSM. For example, if cow_ksm increases too fast, user may decrease the
> > +range of madvise(, , MADV_MERGEABLE).
> > +
> 
> Did you mean "tradeoff between possible delay on KSM COW and swapping
> in copy"?
>
I mean both are tradeoff, or in other words KSM sacrifices time to gain space.
KSM COW please see do_wp_page(), KSM swapping in copy see ksm_might_need_to_copy().

Thanks.
> -- 
> An old man doll... just what I always wanted! - Clara
