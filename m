Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A396849F504
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347161AbiA1IQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232172AbiA1IQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643357781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BBnKl8nE7Ee6nwMtWDvePBrTL+emOty3eMbx0J5SMo=;
        b=g6Cnec25/P7QATAwm8xh7oGBhtetujm1YbWK9T/6qx/9G3m74JNaxbwzTrXiiASWhv9GuH
        HRPNUgDaBo5LVgeJVLLh016x5uK2iGLU+x0XLLX7A1zZpVhbicbl3xGzjYXVBSVv3Rh7G0
        vU5637r1bRwwSuoL+Lp6u1RQGCOfDso=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-3nXafKTZNCO5TlxL5hDggQ-1; Fri, 28 Jan 2022 03:16:10 -0500
X-MC-Unique: 3nXafKTZNCO5TlxL5hDggQ-1
Received: by mail-wm1-f70.google.com with SMTP id ay8-20020a05600c1e0800b00350de81da56so1201642wmb.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4BBnKl8nE7Ee6nwMtWDvePBrTL+emOty3eMbx0J5SMo=;
        b=Frx9U4xIigk+J9br5mGn3RzFKeHLGo53EDjZCVLaVWGkCwNimOFVDUWIenHJS7vp4g
         LkqlV9J7WRPaZZ2YtTo5cUAWh2FaJusSHyJOYxEoAKhms5GGXrc4ngJ724LkkyVL/hJv
         dRjNl2dlRMMQh1Fo26Oc3FavzqJSVblA1qa3W+s0gy2+lALNiNGhl1mjABguNN1IiotZ
         1H7wsyFZviZUj+H4f8n8fHBEdttdqSVWG/SDqjmG6vCAME6whiMukc724VlITPN2ahDQ
         GhD4QzEpVqvydQHJtvCU2+OeN3AWrXDFYzOc7lHap3QNIN0GYkzypHZVQMq+HEWuYI5Z
         UxKg==
X-Gm-Message-State: AOAM530Eidlr2jFIcFaMKZFwA2v7AsLTMstNJ1E+17g2Po50zjp5trFi
        U9t1nFe6Zz7Ds1eFKV6i2i4i31PHA+dzrTS2TSNIojmfgpeV1jIkY3hY1ynboTy8rJG88v58UBD
        hPq0ZVeNgzoTIHwJwGpGlaTpB
X-Received: by 2002:a1c:1fd7:: with SMTP id f206mr14412675wmf.153.1643357769036;
        Fri, 28 Jan 2022 00:16:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/pm9knLUjHzeqe/OjTYleOB/mjTApEoVWLxNq/xJvbn2Qjx+qcQcnNY4fM5/m+rtG4U1BHA==
X-Received: by 2002:a1c:1fd7:: with SMTP id f206mr14412662wmf.153.1643357768748;
        Fri, 28 Jan 2022 00:16:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5c00:522f:9bcd:24a0:cd70? (p200300cbc70e5c00522f9bcd24a0cd70.dip0.t-ipconnect.de. [2003:cb:c70e:5c00:522f:9bcd:24a0:cd70])
        by smtp.gmail.com with ESMTPSA id r2sm6003738wrz.99.2022.01.28.00.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 00:16:08 -0800 (PST)
Message-ID: <eb415c6d-8ae3-1fa4-9c36-efe4231fd8ad@redhat.com>
Date:   Fri, 28 Jan 2022 09:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/4] mm: Rename zap_skip_check_mapping() to
 should_zap_page()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20220128045412.18695-1-peterx@redhat.com>
 <20220128045412.18695-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220128045412.18695-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.22 05:54, Peter Xu wrote:
> The previous name is against the natural way people think.  Invert the meaning
> and also the return value.  No functional change intended.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>

Could have sworn it was me :P

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

