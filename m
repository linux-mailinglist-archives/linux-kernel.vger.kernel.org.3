Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8414D4B1EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbiBKHGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:06:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347575AbiBKHGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:06:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE141037
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644563195; x=1676099195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cNkGNTO7lyqemczwGGXCDcdGty6f622nnJU9sCxAnSI=;
  b=ZpQ5y+lVvTUT1WFZA3q0LPaZ+1f/DwySiGscr5kCoXDTMG+XBK3F3Qrn
   WqXVzE5fXxZ38PcqXw3JLTPtHzcqVU70E+iCgIYnLl5CLiS7Z0rsYuHka
   eYH9y4PtYSBiCBqokvENx4VlbDwDPiXia6i8yRAjpcyEs138ln0KlwCY9
   lUs6t5SSntmKhoIdwEhvVnOOtuyynbficrSngawtQYDfKysCJfkLZz6Tv
   7W7/lello+AQR8iAhh1vGbs2LBbjSZefyktBRMlk4IlA2MQlsmJebjNzM
   2mXGFja/pICP2vrb3ccBRTvEXJ4V5qnbOnSj+RdeBe9sNZxu7pygOBs1P
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="237080188"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="237080188"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="483176474"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 23:06:33 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIQ0m-0004GC-Ns; Fri, 11 Feb 2022 07:06:32 +0000
Date:   Fri, 11 Feb 2022 15:06:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt 57/57] net/ceph/messenger_v2.c:1787:5: error:
 incomplete definition of type 'struct cepn_connection'
Message-ID: <202202111558.NeRjba8E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt
head:   adf69efebc954db1aa7af7b93febbc2a1b51dc6c
commit: adf69efebc954db1aa7af7b93febbc2a1b51dc6c [57/57] libceph: define a structure to track SPARSE_READ reply processing
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220211/202202111558.NeRjba8E-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=adf69efebc954db1aa7af7b93febbc2a1b51dc6c
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt
        git checkout adf69efebc954db1aa7af7b93febbc2a1b51dc6c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/ceph/messenger_v2.c:1783:37: warning: declaration of 'struct cepn_connection' will not be visible outside of this function [-Wvisibility]
   static int prepare_read_data(struct cepn_connection *con)
                                       ^
>> net/ceph/messenger_v2.c:1787:5: error: incomplete definition of type 'struct cepn_connection'
           con->in_data_crc = -1;
           ~~~^
   net/ceph/messenger_v2.c:1783:37: note: forward declaration of 'struct cepn_connection'
   static int prepare_read_data(struct cepn_connection *con)
                                       ^
   net/ceph/messenger_v2.c:1788:47: error: incomplete definition of type 'struct cepn_connection'
           ret = prepare_read_data_len(con, data_len(con->in_msg));
                                                     ~~~^
   net/ceph/messenger_v2.c:1783:37: note: forward declaration of 'struct cepn_connection'
   static int prepare_read_data(struct cepn_connection *con)
                                       ^
   net/ceph/messenger_v2.c:1790:6: error: incomplete definition of type 'struct cepn_connection'
                   con->v2.in_state = IN_S_PREPARE_READ_DATA_CONT;
                   ~~~^
   net/ceph/messenger_v2.c:1783:37: note: forward declaration of 'struct cepn_connection'
   static int prepare_read_data(struct cepn_connection *con)
                                       ^
>> net/ceph/messenger_v2.c:1842:24: error: use of undeclared identifier 'iter'
           if (!iov_iter_is_bvec(iter))
                                 ^
>> net/ceph/messenger_v2.c:1881:10: error: implicit declaration of function 'handle_epilogue' [-Werror,-Wimplicit-function-declaration]
                   return handle_epilogue(con);
                          ^
   net/ceph/messenger_v2.c:1881:10: note: did you mean 'decode_epilogue'?
   net/ceph/messenger_v2.c:573:12: note: 'decode_epilogue' declared here
   static int decode_epilogue(void *p, u32 *front_crc, u32 *middle_crc,
              ^
   net/ceph/messenger_v2.c:1898:24: error: use of undeclared identifier 'iter'
           if (!iov_iter_is_kvec(iter))
                                 ^
>> net/ceph/messenger_v2.c:1951:28: error: incompatible pointer types passing 'struct ceph_connection *' to parameter of type 'struct cepn_connection *' [-Werror,-Wincompatible-pointer-types]
                   return prepare_read_data(con);
                                            ^~~
   net/ceph/messenger_v2.c:1783:54: note: passing argument to parameter 'con' here
   static int prepare_read_data(struct cepn_connection *con)
                                                        ^
   net/ceph/messenger_v2.c:2938:12: error: static declaration of 'handle_epilogue' follows non-static declaration
   static int handle_epilogue(struct ceph_connection *con)
              ^
   net/ceph/messenger_v2.c:1881:10: note: previous implicit declaration is here
                   return handle_epilogue(con);
                          ^
   net/ceph/messenger_v2.c:3012:28: error: incompatible pointer types passing 'struct ceph_connection *' to parameter of type 'struct cepn_connection *' [-Werror,-Wincompatible-pointer-types]
                           ret = prepare_read_data(con);
                                                   ^~~
   net/ceph/messenger_v2.c:1783:54: note: passing argument to parameter 'con' here
   static int prepare_read_data(struct cepn_connection *con)
                                                        ^
>> net/ceph/messenger_v2.c:3014:8: error: use of undeclared identifier 'IN_S_PREPARE_READ_SPARSE_DATA'
                   case IN_S_PREPARE_READ_SPARSE_DATA:
                        ^
   1 warning and 10 errors generated.


vim +1787 net/ceph/messenger_v2.c

  1782	
  1783	static int prepare_read_data(struct cepn_connection *con)
  1784	{
  1785		int ret;
  1786	
> 1787		con->in_data_crc = -1;
  1788		ret = prepare_read_data_len(con, data_len(con->in_msg));
  1789		if (ret == 0)
  1790			con->v2.in_state = IN_S_PREPARE_READ_DATA_CONT;
  1791		return ret;
  1792	}
  1793	
  1794	static void prepare_read_data_cont(struct ceph_connection *con)
  1795	{
  1796		struct bio_vec bv;
  1797	
  1798		if (ceph_test_opt(from_msgr(con->msgr), RXBOUNCE)) {
  1799			con->in_data_crc = crc32c(con->in_data_crc,
  1800						  page_address(con->bounce_page),
  1801						  con->v2.in_bvec.bv_len);
  1802	
  1803			get_bvec_at(&con->v2.in_cursor, &bv);
  1804			memcpy_to_page(bv.bv_page, bv.bv_offset,
  1805				       page_address(con->bounce_page),
  1806				       con->v2.in_bvec.bv_len);
  1807		} else {
  1808			con->in_data_crc = ceph_crc32c_page(con->in_data_crc,
  1809							    con->v2.in_bvec.bv_page,
  1810							    con->v2.in_bvec.bv_offset,
  1811							    con->v2.in_bvec.bv_len);
  1812		}
  1813	
  1814		ceph_msg_data_advance(&con->v2.in_cursor, con->v2.in_bvec.bv_len);
  1815		if (con->v2.in_cursor.total_resid) {
  1816			get_bvec_at(&con->v2.in_cursor, &bv);
  1817			if (ceph_test_opt(from_msgr(con->msgr), RXBOUNCE)) {
  1818				bv.bv_page = con->bounce_page;
  1819				bv.bv_offset = 0;
  1820			}
  1821			set_in_bvec(con, &bv);
  1822			WARN_ON(con->v2.in_state != IN_S_PREPARE_READ_DATA_CONT);
  1823			return;
  1824		}
  1825	
  1826		/*
  1827		 * We've read all data.  Prepare to read epilogue.
  1828		 */
  1829		reset_in_kvecs(con);
  1830		add_in_kvec(con, con->v2.in_buf, CEPH_EPILOGUE_PLAIN_LEN);
  1831		con->v2.in_state = IN_S_HANDLE_EPILOGUE;
  1832	}
  1833	
  1834	static int prepare_sparse_read_data_cont(struct ceph_connection *con)
  1835	{
  1836		int ret;
  1837		struct bio_vec bv;
  1838		char *buf = NULL;
  1839		struct iov_iter *in_iter = &con->v2.in_iter;
  1840		u64 off = 0, len = 0;
  1841	
> 1842		if (!iov_iter_is_bvec(iter))
  1843			return -EIO;
  1844	
  1845		if (ceph_test_opt(from_msgr(con->msgr), RXBOUNCE)) {
  1846			con->in_data_crc = crc32c(con->in_data_crc,
  1847						  page_address(con->bounce_page),
  1848						  con->v2.in_bvec.bv_len);
  1849	
  1850			get_bvec_at(&con->v2.in_cursor, &bv);
  1851			memcpy_to_page(bv.bv_page, bv.bv_offset,
  1852				       page_address(con->bounce_page),
  1853				       con->v2.in_bvec.bv_len);
  1854		} else {
  1855			con->in_data_crc = ceph_crc32c_page(con->in_data_crc,
  1856							    con->v2.in_bvec.bv_page,
  1857							    con->v2.in_bvec.bv_offset,
  1858							    con->v2.in_bvec.bv_len);
  1859		}
  1860	
  1861		if (con->v2.in_cursor.total_resid) {
  1862			get_bvec_at(&con->v2.in_cursor, &bv);
  1863			if (ceph_test_opt(from_msgr(con->msgr), RXBOUNCE)) {
  1864				bv.bv_page = con->bounce_page;
  1865				bv.bv_offset = 0;
  1866			}
  1867			set_in_bvec(con, &bv);
  1868			WARN_ON(con->v2.in_state != IN_S_PREPARE_SPARSE_DATA_CONT);
  1869			return 0;
  1870		}
  1871	
  1872		/* get next extent */
  1873		ret = con->ops->sparse_read(con, &off, &len, &buf);
  1874		if (ret <= 0) {
  1875			if (ret < 0)
  1876				return ret;
  1877	
  1878			reset_in_kvecs(con);
  1879			add_in_kvec(con, con->v2.in_buf, CEPH_EPILOGUE_PLAIN_LEN);
  1880			con->v2.in_state = IN_S_HANDLE_EPILOGUE;
> 1881			return handle_epilogue(con);
  1882		}
  1883	
  1884		ret = prepare_read_data_len(con, off + len);
  1885		if (!ret)
  1886			ceph_msg_data_advance(&con->v2.in_cursor, off);
  1887		return ret;
  1888	}
  1889	
  1890	static int prepare_sparse_read_header(struct ceph_connection *con)
  1891	{
  1892		int ret;
  1893		struct bio_vec bv;
  1894		char *buf = NULL;
  1895		struct iov_iter *in_iter = &con->v2.in_iter;
  1896		u64 off = 0, len = 0;
  1897	
  1898		if (!iov_iter_is_kvec(iter))
  1899			return -EIO;
  1900	
  1901		/* On first call, we have no kvec so don't compute crc */
  1902		if (con->v2.in_kvec_cnt) {
  1903			WARN_ON_ONCE(con->v2.in_kvec_cnt > 1);
  1904			con->in_data_crc = crc32c(con->in_data_crc,
  1905					  con->v2.in_kvecs[0].iov_base,
  1906					  con->v2.in_kvecs[0].iov_len);
  1907		}
  1908	
  1909		ret = con->ops->sparse_read(con, &off, &len, &buf);
  1910		if (ret < 0)
  1911			return ret;
  1912	
  1913		/* No actual data? */
  1914		if (WARN_ON_ONCE(!ret))
  1915			return -EIO;
  1916	
  1917		if (!buf) {
  1918			ret = prepare_read_data_len(con, off + len);
  1919			if (!ret) {
  1920				ceph_msg_data_advance(&con->v2.in_cursor, off);
  1921				con->v2.in_state = IN_S_PREPARE_SPARSE_DATA_CONT;
  1922			}
  1923			return ret;
  1924		}
  1925	
  1926		WARN_ON_ONCE(con->v2.in_state != IN_S_PREPARE_SPARSE_DATA_HDR);
  1927		reset_in_kvecs(con);
  1928		add_in_kvec(con, buf, len);
  1929		return 0;
  1930	}
  1931	
  1932	static int prepare_sparse_read_data(struct ceph_connection *con)
  1933	{
  1934		if (WARN_ON_ONCE(!con->ops->sparse_read))
  1935			return -EOPNOTSUPP;
  1936	
  1937		if (!con_secure(con))
  1938			con->in_data_crc = -1;
  1939	
  1940		reset_in_kvecs(con);
  1941		con->v2.in_state = IN_S_PREPARE_SPARSE_DATA_HDR;
  1942		return prepare_sparse_read_header(con);
  1943	}
  1944	
  1945	static int prepare_read_tail_plain(struct ceph_connection *con)
  1946	{
  1947		struct ceph_msg *msg = con->in_msg;
  1948	
  1949		if (!front_len(msg) && !middle_len(msg)) {
  1950			WARN_ON(!data_len(msg));
> 1951			return prepare_read_data(con);
  1952		}
  1953	
  1954		reset_in_kvecs(con);
  1955		if (front_len(msg)) {
  1956			add_in_kvec(con, msg->front.iov_base, front_len(msg));
  1957			WARN_ON(msg->front.iov_len != front_len(msg));
  1958		}
  1959		if (middle_len(msg)) {
  1960			add_in_kvec(con, msg->middle->vec.iov_base, middle_len(msg));
  1961			WARN_ON(msg->middle->vec.iov_len != middle_len(msg));
  1962		}
  1963	
  1964		if (data_len(msg)) {
  1965			if (msg->sparse_read)
  1966				con->v2.in_state = IN_S_PREPARE_SPARSE_DATA;
  1967			else
  1968				con->v2.in_state = IN_S_PREPARE_READ_DATA;
  1969		} else {
  1970			add_in_kvec(con, con->v2.in_buf, CEPH_EPILOGUE_PLAIN_LEN);
  1971			con->v2.in_state = IN_S_HANDLE_EPILOGUE;
  1972		}
  1973		return 0;
  1974	}
  1975	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
